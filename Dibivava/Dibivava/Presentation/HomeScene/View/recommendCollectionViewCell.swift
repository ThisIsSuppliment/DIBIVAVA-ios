//
//  recommendCollectionViewCell.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/19.
//

import UIKit


class recommendCollectionViewCell: UICollectionViewCell {
    static let identifier = "recommendCollectionViewCell"
    private let clcikImg = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true //chevron.right
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .darkGray
    }
    public var Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }

    public let roundview = UIView().then{
           $0.layer.cornerRadius = 20
           $0.layer.masksToBounds = true
           $0.layer.borderWidth = 1
           $0.layer.borderColor = UIColor(rgb: 0xEFEFEF).cgColor
           $0.backgroundColor = .clear
       }
    public var nameLabel = UILabel().then{
        $0.text = "불러오기 실패"
        $0.textColor = UIColor(rgb: 0x424242)
        $0.font = .pretendard(.Bold, size: 14)
        $0.sizeToFit()
    }
    private func layout(){
        self.clcikImg.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)

            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        self.nameLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
        }
        self.Img.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(70)
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
        self.roundview.addSubview(Img)
        self.roundview.addSubview(nameLabel)
        self.roundview.addSubview(clcikImg)
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
