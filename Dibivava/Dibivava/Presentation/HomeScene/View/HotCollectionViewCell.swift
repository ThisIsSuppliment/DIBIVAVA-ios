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
    public var companyLabel = UILabel().then {
        $0.font = .pretendard(.Medium, size: 12)
        $0.numberOfLines = 0
        $0.textColor = UIColor(hexString: "#B9B9B9")
        $0.text = "회사"
    }
    public var ImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
    }
    public var name = UILabel().then  {
        $0.font = .pretendard(.Medium, size: 14)
        $0.textColor = UIColor(hexString: "#666666")
        $0.text = "영양제"
    }
    public var des = UILabel().then  {
        $0.font = .pretendard(.Medium, size: 14)
        $0.textColor = UIColor(hexString: "#666666")
        $0.text = "설명"
        $0.numberOfLines = 0
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
        self.addSubview(self.ImageView)
        self.addSubview(self.moreButton)
        self.addSubview(self.name)
        self.addSubview(self.des)
        self.addSubview(self.companyLabel)
        self.backgroundColor = .white
    }
    
    private func layout() {
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
        }
        
        self.ImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(38)
        }
        
        self.moreButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        self.name.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(self.ImageView.snp.top).offset(-10)
        }
        self.companyLabel.snp.makeConstraints{
            $0.leading.equalTo(self.name.snp.trailing).offset(5)
            $0.bottom.equalTo(self.ImageView.snp.top).offset(-10)
        }
        self.des.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalTo(self.ImageView.snp.bottom).offset(10)

        }
    }
}
