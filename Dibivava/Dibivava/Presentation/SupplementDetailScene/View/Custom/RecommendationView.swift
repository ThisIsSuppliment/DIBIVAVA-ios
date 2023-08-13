//
//  RecommendationView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/13.
//

import UIKit
import RxSwift
import SnapKit
import Then

class RecommendationView: UIView, UICollectionViewDelegate {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    
    enum Section: String, CaseIterable {
        case main
    }
    
    // MARK: - UI
    
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureCollectionViewLayout(.functionality)
    ).then {
        $0.delegate = self
        $0.register(
            RecommendationCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier
        )
    }
    
    // MARK: - Property
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: DataSource?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureSubView()
        self.configureConstraints()
        self.configureDataSource()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    func applySnapshot(_ recommendations: [String]) {
        if recommendations.isEmpty {
            return
        }
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(100)
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
        self.addSubview(collectionView)
    }
    
    func configureConstraints() {
        self.collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
    }

    func configureDataSource() {
        self.dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommendationCollectionViewCell.identifier,
                for: indexPath
            ) as! RecommendationCollectionViewCell
            
//            cell.configure(title: item)

            return cell
        }
    }
}
