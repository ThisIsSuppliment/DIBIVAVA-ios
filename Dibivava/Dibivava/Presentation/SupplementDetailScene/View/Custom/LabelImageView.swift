//
//  LabelImageView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/09/24.
//

import UIKit

final class LabelImageView: UIView {
//    let checkImageView: UIButton = UIButton().then {
//        $0.setImage(UIImage(named: "GrayMark"), for: .normal)
//        $0.setImage(UIImage(named: "GMP"), for: .selected)
//        $0.contentMode = .scaleAspectFit
//    }
    
    private let checkImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .pretendard(.Regular, size: 12)
    }
    
    private var labelImageViewType: LabelImageViewType? {
        didSet {
            guard let labelImageViewType else { return }
            self.checkImageView.image = UIImage(named: labelImageViewType.imageName)
        }
    }
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            self.titleLabel.text = text
        }
    }

    init(frame: CGRect, labelImageViewType: LabelImageViewType) {
        super.init(frame: frame)
        self.labelImageViewType = labelImageViewType
        setupUI()
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
            make.top.leading.equalToSuperview()
        }
        
        self.checkImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.verticalEdges.bottom.equalToSuperview()
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(self.titleLabel)
        }
    }
}


