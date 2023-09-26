//
//  LabelImageView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/09/24.
//

import UIKit

final class LabelImageView: UIView {
    
    private let checkImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .pretendard(.Regular, size: 13)
    }
    
    var labelImageViewType: LabelImageViewType? {
        didSet {
            guard let labelImageViewType else { return }
            self.checkImageView.image = UIImage(named: labelImageViewType.imageName)
            self.titleLabel.text = labelImageViewType.text
        }
    }

    init(labelImageViewType: LabelImageViewType) {
        super.init(frame: .zero)
        
        self.labelImageViewType = labelImageViewType
        self.checkImageView.image = UIImage(named: labelImageViewType.imageName)
        self.titleLabel.text = labelImageViewType.text
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

private extension LabelImageView {
    func setupUI() {
        [checkImageView, titleLabel].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        self.checkImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}


