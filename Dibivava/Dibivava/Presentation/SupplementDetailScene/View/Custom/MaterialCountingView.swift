//
//  MaterialCountingView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

final class MaterialCountingView: UIView {
    
    private let labelStack: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let countLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .pretendard(.Regular, size: 16)
        $0.text = " "
    }
    
    let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .pretendard(.Regular, size: 14)
    }
    
    let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "0개")
    }
    
    var count: Int? {
        didSet {
            guard let count = count
            else{
                self.countLabel.text = "0개"
                self.imageView.image = UIImage(named: "0개")
                return
            }
            
            self.countLabel.text = "\(count)개"
            
            if count == 0 {
                self.imageView.image = UIImage(named: "0개")
            } else if count <= 5 {
                self.imageView.image = UIImage(named: "5개")
            } else {
                self.imageView.image = UIImage(named: "10개")
            }
        }
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

private extension MaterialCountingView {
    func configureSubviews() {
        [titleLabel, countLabel, imageView].forEach {
            self.labelStack.addArrangedSubview($0)
        }
        
        [labelStack].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        self.labelStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
