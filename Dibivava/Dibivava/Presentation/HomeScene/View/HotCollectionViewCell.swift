//
//  HotCollectionViewCell.swift
//  Dibivava
//
//  Created by 최지철 on 2023/09/05.
//

import UIKit

final class HotCollectionViewCell: UICollectionViewCell {
    static let identifier = "HotCollectionViewCell"
    
    public var titleLabel = UILabel().then {
        $0.font = .pretendard(.Bold, size: 24)
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.text = "제목"
    }
    
    public let imotionImageView = UIImageView().then {
        $0.contentMode = .center
        $0.backgroundColor = .clear
    }
        
    public let moreButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("바로가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .init(width: 0, height: 2)
        self.layer.cornerRadius = 8
        
        self.addSubView()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.imotionImageView)
        self.addSubview(self.moreButton)
        self.backgroundColor = .white
    }
    
    private func layout() {
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
        }
        
        self.imotionImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(250)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(38)
        }
        
        self.moreButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
}
