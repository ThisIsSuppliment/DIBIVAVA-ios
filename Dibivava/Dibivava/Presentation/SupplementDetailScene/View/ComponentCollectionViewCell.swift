//
//  ComponentCollectionViewCell.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit
import SnapKit
import Then

final class ComponentCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: ComponentCollectionViewCell.self)
    
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "건강기능 식품 성분 이름"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .orange // 추후 삭제
        configureSubviews()
        configureConstraints()
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.25
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}

private extension ComponentCollectionViewCell {
    func configureSubviews() {
        [titleLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
