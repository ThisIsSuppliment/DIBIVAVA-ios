//
//  ComponentView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa


final class ComponentView: UIView, UICollectionViewDelegate {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Material>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Material>
    
    enum Section: String, CaseIterable {
        case addictive
        case main
        case sub
        
        var inKorean: String {
            switch self {
            case .main:
                return "기능성 원료"
            case .sub:
                return "부원료"
            case .addictive:
                return "첨가물"
            }
        }
        
        var materialType: MaterialType {
            switch self {
            case .main:
                return .main
            case .sub:
                return .sub
            case .addictive:
                return .addictive
            }
        }
    }
    
    // MARK: - UI
    let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.text = "이런 성분들이 있어요!"
    }
    
    let componentCountingStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    let main: ComponentCountingView = ComponentCountingView().then {
        $0.titleLabel.text = "기능성 원료"
    }
    
    let sub: ComponentCountingView = ComponentCountingView().then {
        $0.titleLabel.text = "부원료"
    }
    
    let add: ComponentCountingView = ComponentCountingView().then {
        $0.titleLabel.text = "첨가물"
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureCollectionViewLayout(.component)
    ).then {
        $0.delegate = self
        $0.allowsMultipleSelection = true
        $0.isScrollEnabled = false
        $0.register(
            ComponentCollectionViewCell.self,
            forCellWithReuseIdentifier: ComponentCollectionViewCell.identifier
        )
        $0.register(
            ComponentSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ComponentSectionHeaderView.identifier
        )
    }
    
    // MARK: - Property
    
    private var dataSource: DataSource?
    private var heightConstraint: Constraint?
    private var isExpanded = false
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let heightChangedSubject = PublishSubject<CGFloat>()
    
    var heightChanged: Observable<CGFloat> {
        return heightChangedSubject.asObservable()
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.configureSubView()
        self.configureConstraints()
        self.configureDataSource()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    func applySnapshot(_ materialByType: [MaterialType: [Material]]) {
        var snapshot = Snapshot()
        
        for section in Section.allCases {
            if let materials = materialByType[section.materialType] {
                snapshot.appendSections([section])
                snapshot.appendItems(materials)
            }
        }
        
        self.dataSource?.apply(snapshot, animatingDifferences: false)
                
        self.collectionView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(self.collectionView.contentSize.height)
        }
    }
}

// MARK: - Private Methods

private extension ComponentView {
    func configureCollectionViewLayout(_ section: SupplementDetailLayout) -> UICollectionViewLayout {
        return section.createLayout()
    }
    
    func configureSubView() {
        [add, main, sub].forEach {
            self.componentCountingStackView.addArrangedSubview($0)
        }
        
        [titleLabel, componentCountingStackView, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        self.componentCountingStackView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.componentCountingStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.greaterThanOrEqualTo(self.collectionView.contentSize.height)
            make.bottom.equalToSuperview().inset(12)
        }
    }

    func configureDataSource() {
        self.dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ComponentCollectionViewCell.identifier,
                for: indexPath
            ) as! ComponentCollectionViewCell
            
            let nameOfTerms = item.terms?.joined(separator: "  ") ?? ""
            let descriptionOfTerms = item.termsDescription ?? ""

            cell.delegate = self
            cell.configure(title: item.name ?? "없음",
                           isAdd: item.category == "additive" && item.name != nil,
                           terms: nameOfTerms + "\n\n" + descriptionOfTerms,
                           level: item.level)
            
            return cell
        }
        
        self.dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ComponentSectionHeaderView.identifier,
                for: indexPath
            ) as? ComponentSectionHeaderView
            else {
                return UICollectionReusableView()
            }
            
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            headerView.configure(title: section?.inKorean ?? "") // 추후 수정
            
            return headerView
        }
    }
}

extension ComponentView: ComponentCollectionViewCellDelegate {
    func showHideButtonTapped(_ cell: ComponentCollectionViewCell, sender: Bool) {
        guard let snapshot = dataSource?.snapshot()
        else { return }
        
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        self.collectionView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(self.collectionView.contentSize.height)
        }
    }
}
