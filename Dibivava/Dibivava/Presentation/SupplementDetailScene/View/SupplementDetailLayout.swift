//
//  SupplementDetailLayout.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/18.
//

import UIKit

enum SupplementDetailLayout {
    case functionality
    case material
    case recommendation
    
    func createLayout(itemCount: Int = 5) -> UICollectionViewCompositionalLayout {
        switch self {
        case .functionality:
            return self.createFunctionalityLayout()
        case .material:
            return self.createMaterialLayout(itemCount: itemCount)
        case .recommendation:
            return self.createRecommendationLayout()
        }
    }
}

private extension SupplementDetailLayout {
    func createFunctionalityLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(100),
                heightDimension: .absolute(35)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(100),
                heightDimension: .absolute(35)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            return section
        }
    }
    
    func createMaterialLayout(itemCount: Int) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            // 새로 배치
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            let sectionHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50))

            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: sectionHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            sectionHeader.pinToVisibleBounds = false

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [sectionHeader]
            section.contentInsets = .init(top: 0, leading: 16, bottom: 10, trailing: 16)
            section.interGroupSpacing = 10
            return section
        }
    }
    
    func createRecommendationLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(150),
                heightDimension: .absolute(200)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(150),
                heightDimension: .absolute(200)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
            return section
        }
    }
}
