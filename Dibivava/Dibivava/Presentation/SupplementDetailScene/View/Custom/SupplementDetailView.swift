//
//  SupplementDetailView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

final class SupplementDetailView: UIView {
    
    private var gmpLabelImageView: LabelImageView?
    private var allergyLabelImageView: LabelImageView = LabelImageView(labelImageViewType: .allergy(isSelected: false))
    private var carcinogensLabelImageView: LabelImageView = LabelImageView(labelImageViewType: .carcinogens(isSelected: false))
    
    private let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let nameLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 18)
        $0.numberOfLines = 2
    }
    
    private let companyLabel: UILabel = UILabel().then {
        $0.textColor = .systemGray
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 14)
        $0.numberOfLines = 2
    }
    
    private let categoryAndIntakeMethodLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 14)
        $0.numberOfLines = 2
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
            self.categoryAndIntakeMethodLabel.text = categoryAndIntakeMethod
        }
    }
    
    var isGMP: Int? = 0 {
        didSet {
            self.setGMPLabelImageView(isGMP: isGMP)
        }
    }
    
    var isAllergy: Int = 0 {
        didSet {
//            self.allergyLabelImageView = LabelImageView(
//                frame: .zero,
//                labelImageViewType: .allergy(isSelected: isA > 0 ? true : false)
//            )
            self.allergyLabelImageView.labelImageViewType = .allergy(isSelected: isAllergy > 0 ? true : false)
        }
    }
    
    var isC: Int = 0 {
        didSet {
//            self.carcinogensLabelImageView = LabelImageView(
//                frame: .zero,
//                labelImageViewType: .carcinogens(isSelected: isC > 0 ? true : false)
//            )
            self.carcinogensLabelImageView.labelImageViewType = .carcinogens(isSelected: isC > 0 ? true : false)
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
        [imageView, companyLabel, nameLabel, categoryAndIntakeMethodLabel, allergyLabelImageView, carcinogensLabelImageView].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {                
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        self.companyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(self.snp.centerX)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.companyLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        self.categoryAndIntakeMethodLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        self.allergyLabelImageView.snp.makeConstraints { make in
            make.top.equalTo(self.categoryAndIntakeMethodLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(20)
        }
        
        self.carcinogensLabelImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.allergyLabelImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10).priority(.low)
            make.centerY.equalTo(self.allergyLabelImageView).inset(10)
        }
    }
    
    func setGMPLabelImageView(isGMP: Int?) {
        guard isGMP == 1 else { return }
        
        self.gmpLabelImageView = LabelImageView(labelImageViewType: .gmp)
        
        guard let gmpLabelImageView = self.gmpLabelImageView else { return }
        
        self.addSubview(gmpLabelImageView)
        
        gmpLabelImageView.snp.makeConstraints { make in
            make.top.equalTo(self.companyLabel.snp.top)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        gmpLabelImageView.labelImageViewType = .gmp
    }
}
