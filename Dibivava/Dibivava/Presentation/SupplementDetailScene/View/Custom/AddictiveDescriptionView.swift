//
//  AddictiveDescriptionView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/09/20.
//

import UIKit
import SnapKit

final class AddictiveDescriptionView: UIView {
    
    private var labelImageViewType: LabelImageViewType
    
    private let imageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "GMP")
        $0.contentMode = .scaleAspectFit
    }
    
    private let label: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 12)
    }
    
    var textLabel: String? {
        didSet {
            guard let textLabel = textLabel else { return }
            
            let attributedText = NSMutableAttributedString(string: textLabel)
            attributedText.addAttribute(.font,
                                        value: UIFont.pretendard(.Bold, size: 14),
                                        range: labelImageViewType.boldRange ?? NSRange())
            
            self.label.attributedText = attributedText
        }
    }
    
    init(labelImageViewType: LabelImageViewType) {
        self.labelImageViewType = labelImageViewType
        
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.configureSubView()
        self.configureConstraints()
        self.imageView.image = UIImage(named: labelImageViewType.imageName)
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
            make.size.equalTo(35)
        }
        
        self.label.snp.makeConstraints { make in
            make.leading.equalTo(self.imageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
            make.verticalEdges.equalToSuperview()//.inset(5)
        }
    }
}
