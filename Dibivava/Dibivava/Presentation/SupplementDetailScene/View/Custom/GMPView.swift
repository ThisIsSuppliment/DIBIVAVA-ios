//
//  GMPView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/27.
//

import UIKit

final class GMPView: UIView {
    let gmpImageView: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "GrayMark"), for: .normal)
        $0.setImage(UIImage(named: "GMP"), for: .selected)
        $0.contentMode = .scaleAspectFit
    }
    
    let gmpLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "GMP 인증"
        $0.font = .pretendard(.Regular, size: 12)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        [gmpLabel, gmpImageView].forEach {
            self.addSubview($0)
        }
        
        self.gmpLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        self.gmpImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.verticalEdges.bottom.equalToSuperview()
            make.leading.equalTo(self.gmpLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(self.gmpLabel)
        }
    }
}
