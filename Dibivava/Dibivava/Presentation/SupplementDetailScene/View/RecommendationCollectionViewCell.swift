//
//  RecommendationCollectionViewCell.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/10.
//

import UIKit
import Then

class RecommendationCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: RecommendationCollectionViewCell.self)
    
    private let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "noresult")
    }
    
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 17)
    }
    
    private let companyLabel: BasePaddingLabel = BasePaddingLabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.font = .pretendard(.Regular, size: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.25
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        self.configureSubviews()
        self.configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.titleLabel.text = ""
        self.companyLabel.text = ""
    }
    
    func configure(title: String, companyLabel: String) {
        self.titleLabel.text = title
        self.companyLabel.text = companyLabel
    }
}

private extension RecommendationCollectionViewCell {
    func configureSubviews() {
        [imageView, titleLabel, companyLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        self.companyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
