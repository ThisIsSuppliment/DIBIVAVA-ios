//
//  FunctionalityCollectionViewCell.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

class FunctionalityCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: FunctionalityCollectionViewCell.self)
    
    private let titleLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.25
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}

private extension FunctionalityCollectionViewCell {
    func configureSubviews() {
        [titleLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview() //.inset(20)
        }
    }
}
