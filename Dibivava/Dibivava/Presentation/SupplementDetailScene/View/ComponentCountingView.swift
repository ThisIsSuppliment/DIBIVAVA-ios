//
//  ComponentCountingView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

final class ComponentCountingView: UIView {
    
    private let labelStack: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let countLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = " "
    }
    
    let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "5개") // 후추 수정
//        $0.backgroundColor = .yellow // 후추 수정
    }
    
    private let functionalityView: FunctionalityView = FunctionalityView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureSubviews()
        self.configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(_ functionalities: [String]) {
        self.functionalityView.applySnapshot(functionalities)
    }
}

private extension ComponentCountingView {
    func configureSubviews() {
        [countLabel, imageView, titleLabel].forEach {
            self.labelStack.addArrangedSubview($0)
        }
        
        [labelStack].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        
        self.labelStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
