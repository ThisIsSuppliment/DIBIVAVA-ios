//
//  SupplementDetailView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

final class SupplementDetailView: UIView {
    
    private let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let gmp: LabelImageView = LabelImageView(frame: .zero, labelImageViewType: .gmp).then {
        $0.text = "GMP 인증"
    }
    
    private let allergyLabelImageView: LabelImageView = LabelImageView(frame: .zero, labelImageViewType: .allergy(isSelected: true)).then {
        $0.text = "알레르기 유발 물질"
        $0.backgroundColor = .yellow
    }
    
    private let carcinogensLabelImageView: LabelImageView = LabelImageView(frame: .zero, labelImageViewType: .carcinogens(isSelected: true)).then {
        $0.text = "발암 유발(가능) 물질"
        $0.backgroundColor = .orange
    }
    
    private let nameLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 18)
    }
    
    private let companyLabel: UILabel = UILabel().then {
        $0.textColor = .systemGray
        $0.textAlignment = .left
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 14)
    }
    
    private let descriptionLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 14)
    }
    
    var imageURL: String? {
        didSet {
            guard let imageURL = imageURL,
                  let url = URL(string: imageURL)
            else {
                self.imageView.image = UIImage(named: "noresult")
                return
            }
            self.imageView.load(url: url)
        }
    }
    
    var name: String? {
        didSet {
            guard let name = name else { return }
            self.nameLabel.text = name
        }
    }
    
    var company: String? {
        didSet {
            guard let company = company else { return }
            self.companyLabel.text = company
        }
    }
    
    var categoryAndIntakeMethod: String? {
        didSet {
            guard let categoryAndIntakeMethod = categoryAndIntakeMethod else { return }
            self.descriptionLabel.text = categoryAndIntakeMethod
        }
    }
    
    var isGMP: Int? = 0 {
        didSet {
            guard let isGMP = isGMP
            else {
                return
            }
            self.gmp.isHidden = isGMP == 0 ? true : false
        }
    }
    
    var isA: Int = 0 {
        didSet {
//            self.allergy.text = "알레르기 유발 물질\t\(isA)개"
        }
    }
    
    var isC: Int = 0 {
        didSet {
//            self.carcinogens.text = "발암 유발(가능) 물질\t\(isC)개"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureSubviews()
        self.configureConstraints()
        
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SupplementDetailView {
    func configureSubviews() {        
        [gmp, imageView, companyLabel, nameLabel, descriptionLabel, allergyLabelImageView, carcinogensLabelImageView].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {                
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        self.gmp.snp.makeConstraints { make in
            make.top.equalTo(self.companyLabel.snp.top)
            make.leading.equalTo(self.companyLabel.snp.trailing).offset(10).priority(.low)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        self.companyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.companyLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        self.allergyLabelImageView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        self.carcinogensLabelImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.allergyLabelImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10).priority(.low)
            make.centerY.equalTo(self.allergyLabelImageView).inset(10)
        }
    }
}
