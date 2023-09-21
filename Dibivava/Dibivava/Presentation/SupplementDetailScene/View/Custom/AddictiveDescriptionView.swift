//
//  AddictiveDescriptionView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/09/20.
//

import UIKit
import SnapKit

final class AddictiveDescriptionView: UIView {
    
    private let imageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "GMP")
        $0.contentMode = .scaleAspectFit
    }
    
    private let label: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 12)
        $0.text = "설명"
    }
    
    var textLabel: String? {
        didSet {
            guard let textLabel = textLabel else { return }
            self.label.text = textLabel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
        self.configureSubView()
        self.configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddictiveDescriptionView {
    func configureSubView() {
        [imageView, label].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(self.label)
        }
        
        self.label.snp.makeConstraints { make in
            make.leading.equalTo(self.imageView.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
}
