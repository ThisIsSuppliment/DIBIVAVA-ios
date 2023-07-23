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
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    
    enum Section: String, CaseIterable {
        case add
        case main
        case sub
        
        var inKorean: String {
            switch self {
            case .main:
                return "기능성 원료"
            case .sub:
                return "부원료"
            case .add:
                return "첨가물"
            }
        }
    }
    
    // MARK: - UI
    let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.boldSystemFont(ofSize: 18)
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
        $0.imageView.image = UIImage(named: "10개")
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureCollectionViewLayout(.component)
    ).then {
        $0.delegate = self
        $0.allowsMultipleSelection = true
        $0.register(
            ComponentCollectionViewCell.self,
            forCellWithReuseIdentifier: ComponentCollectionViewCell.identifier
        )
        $0.register(
            ComponentSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ComponentSectionHeaderView.identifier
        )
        $0.isScrollEnabled = false
    }
    
    // MARK: - Property
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: DataSource?
    
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
    
    func applySnapshot(_ ComponentByCategory: [String: [String]]) {
        var snapshot = Snapshot()
        
        for type in Section.allCases {
            if let Components = ComponentByCategory[type.rawValue] {
                snapshot.appendSections([type])
                snapshot.appendItems(Components)
            }
        }
        
        self.dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Private Methods

private extension ComponentView {
    func configureCollectionViewLayout(_ section: SupplementDetailLayout) -> UICollectionViewLayout {
        return section.createLayout()
    }
    
    func configureSubView() {
        [main, sub, add].forEach {
            self.componentCountingStackView.addArrangedSubview($0)
        }
        
        [titleLabel, componentCountingStackView, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        self.componentCountingStackView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.componentCountingStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
//            make.height.greaterThanOrEqualTo(800)
            make.bottom.equalToSuperview().priority(.low)
        }
    }

    func configureDataSource() {
        self.dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ComponentCollectionViewCell.identifier,
                for: indexPath
            ) as! ComponentCollectionViewCell
            
            cell.configure(title: item)
            
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
            headerView.configure(title: section?.inKorean ?? "", count: 10) // 추후 수정
            
            return headerView
        }
    }
}