//
//  SupplementDetailView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

final class SupplementDetailView: UIView {
    
    let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "noresult")
    }

    private let labelStack: UIStackView = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    let nameLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 18)
    }
    
    let companyLabel: UILabel = UILabel().then {
        $0.textColor = .systemGray
        $0.textAlignment = .center
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 14)
    }
    
    let descriptionLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = " "
        $0.font = .pretendard(.Regular, size: 14)
    }
    
    private let functionalityView: FunctionalityView = FunctionalityView()
    
    var imageURL: String? {
        didSet {
            guard let imageURL = imageURL,
                  let url = URL(string: imageURL)
            else {
                return
            }
            self.imageView.load(url: url)
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
        self.functionalityView.applySnapshot(functionalities)
    }
}

private extension SupplementDetailView {
    func configureSubviews() {
        [companyLabel, nameLabel, descriptionLabel].forEach {
            self.labelStack.addArrangedSubview($0)
        }
        
        [imageView, labelStack, functionalityView].forEach {
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
            make.horizontalEdges.equalToSuperview().inset(10)
        }

        self.functionalityView.snp.makeConstraints { make in
            make.top.equalTo(self.labelStack.snp.bottom).offset(10)
            make.horizontalEdges.width.equalToSuperview()
            make.height.equalTo(self.functionalityView.collectionView.snp.height)
            make.bottom.equalToSuperview().priority(.low)
        }
    }
}
