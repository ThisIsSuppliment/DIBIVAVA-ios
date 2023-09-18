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

    private let labelStack: UIStackView = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    private let gmp: GMPView = GMPView().then {
        $0.gmpLabel.text = "GMP 인증"
    }
    
    private let allergy: UILabel = UILabel().then {
        $0.font = .pretendard(.Regular, size: 14)
        $0.text = "알레르기 유발"
    }
    
    private let c: UILabel = UILabel().then {
        $0.font = .pretendard(.Regular, size: 14)
        $0.text = "발암 유발 물질"
    }
    
    private let nameLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 18)
    }
    
    private let companyLabel: UILabel = UILabel().then {
        $0.textColor = .systemGray
        $0.textAlignment = .center
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 14)
    }
    
    private let descriptionLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 14)
    }
    
//    private let functionalityView: FunctionalityView = FunctionalityView()
    
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
            self.allergy.text = "알레르기 유발 물질    \(isA)개"
        }
    }
    
    var isC: Int = 0 {
        didSet {
            self.c.text = "발암 유발 물질    \(isC)개"
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
    
    func apply(_ functionalities: [String]) {
//        self.functionalityView.applySnapshot(functionalities)
    }
}

private extension SupplementDetailView {
    func configureSubviews() {
        [companyLabel, nameLabel, descriptionLabel, allergy, c].forEach {
            self.labelStack.addArrangedSubview($0)
        }
        
        [imageView, labelStack, gmp].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {                
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        self.labelStack.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        self.gmp.snp.makeConstraints { make in
            make.top.equalTo(self.labelStack.snp.top)
            make.leading.equalTo(self.labelStack.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }

//        self.functionalityView.snp.makeConstraints { make in
//            make.top.equalTo(self.labelStack.snp.bottom).offset(10)
//            make.horizontalEdges.width.equalToSuperview()
//            make.height.equalTo(self.functionalityView.collectionView.snp.height)
//            make.bottom.equalToSuperview().priority(.low)
//        }
    }
}
