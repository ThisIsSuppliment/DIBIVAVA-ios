//
//  RecommendationView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/13.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class RecommendationView: UIView, UICollectionViewDelegate {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SupplementObject>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SupplementObject>
    
    enum Section: String, CaseIterable {
        case main
    }
    
    // MARK: - UI
    
    let titleLabel: UILabel = UILabel().then {
        $0.numberOfLines = 2
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.text = "현재 보고 계신 건강기능식품보다\n첨가제가 적어요!"
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureCollectionViewLayout(.recommendation)
    ).then {
        $0.delegate = self
        $0.register(
            RecommendationCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier
        )
    }
    
    // MARK: - Property
    private let itemSelectedSubject: PublishRelay<IndexPath> = .init()
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: DataSource?
    
    var itemSelected: Driver<IndexPath> {
        return itemSelectedSubject.asDriver(onErrorDriveWith: .never())
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureSubView()
        self.configureConstraints()
        self.configureDataSource()
        
        self.backgroundColor = .white
        
        self.collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.itemSelectedSubject.accept(indexPath)
            })
            .disposed(by: self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    func applySnapshot(_ recommendations: [SupplementObject]) {
        if recommendations.isEmpty {
            self.titleLabel.isHidden = true
            self.collectionView.isHidden = true
            return
        }
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(recommendations)
        
        self.dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Private Methods

private extension RecommendationView {
    func configureCollectionViewLayout(_ section: SupplementDetailLayout) -> UICollectionViewLayout {
        return section.createLayout()
    }
    
    func configureSubView() {
        [titleLabel, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(15).priority(.low)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }

    func configureDataSource() {
        self.dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommendationCollectionViewCell.identifier,
                for: indexPath
            ) as! RecommendationCollectionViewCell
            
            cell.configure(name: item.name, company: item.company)
            cell.imageURL = item.imageLink

            return cell
        }
    }
}
