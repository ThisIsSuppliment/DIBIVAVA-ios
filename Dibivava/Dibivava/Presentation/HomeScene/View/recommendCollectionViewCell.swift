//
//  recommendCollectionViewCell.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/19.
//

import UIKit

class recommendCollectionViewCell: UICollectionViewCell {
    static let identifier = "recommendCollectionViewCell"
    public var Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    public var innerLabel = UILabel().then{
        $0.text = "asdasd"
        $0.textColor = UIColor(rgb: 0x424242)
        $0.font = .pretendard(.Regular, size: 14)
        $0.numberOfLines = 2
    }
    public let roundview = UIView().then{
           $0.layer.cornerRadius = 20
           $0.layer.masksToBounds = true
           $0.layer.borderWidth = 1
           $0.layer.borderColor = UIColor(rgb: 0xEFEFEF).cgColor
           $0.backgroundColor = .clear
       }
    public var nameLabel = UILabel().then{
        $0.text = "비타민"
        $0.textColor = UIColor(rgb: 0x424242)
        $0.font = .pretendard(.Bold, size: 14)
        $0.numberOfLines = 2
    }
    private func layout(){
        self.nameLabel.snp.makeConstraints{
            $0.top.equalTo(self.roundview.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        self.innerLabel.snp.makeConstraints{
            $0.top.equalTo(self.Img.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
        }
        self.Img.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.roundview.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(111)
        }
    }
    private func addSubView(){
        self.addSubview(roundview)
        self.addSubview(nameLabel)
        self.roundview.addSubview(Img)
        self.roundview.addSubview(innerLabel)
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addSubView()

        self.layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
