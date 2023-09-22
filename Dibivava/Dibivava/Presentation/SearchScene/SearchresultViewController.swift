//
//  SearchresultViewController.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/19.
//

import UIKit

class SearchresultViewController: UIViewController {
    private let resultLabel = UILabel().then{
        $0.text = "공공데이터와 실제 제품 정보간 차이로 인해 약사님이 직접 제품정보를 재검수중이에요.\n 아래 ‘우선 검수 요청’을 눌러주시면 우선 검토할게요!"
        $0.font = .pretendard(.SemiBold, size: 12)
        $0.textColor = UIColor(hexString: "#666670")
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    private let Img = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "postLog")
        $0.layer.masksToBounds = true
        $0.backgroundColor = .clear
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    private let updateBtn = UIButton().then{
        $0.setTitle("우선 검수 요청", for: .normal)
        $0.setTitleColor(.mainred, for: .normal)
        $0.titleLabel?.font = .pretendard(.ExtraBold, size: 15)
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexString: "#FF4D4F").cgColor
        $0.backgroundColor = .white
    }
    private let closeBtn = UIButton().then{
        $0.setTitle("닫기", for: .normal)
        $0.titleLabel?.font = .pretendard(.ExtraBold, size: 15)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .mainred
    }
    private func layout(){
        self.resultLabel.snp.makeConstraints{
            $0.top.equalTo(Img.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        self.Img.snp.makeConstraints{
            $0.bottom.equalTo(updateBtn.snp.top).offset(-110)
            $0.leading.equalToSuperview().offset(71)
            $0.trailing.equalToSuperview().offset(-72)
            $0.height.equalTo(134)
        }
        self.closeBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-19)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(48)
        }
        self.updateBtn.snp.makeConstraints{
            $0.bottom.equalTo(self.closeBtn.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(48)
        }
        self.contentView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(120)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(490)
            $0.width.equalTo(327)
        }
    }
    @objc private func closeBtnClick() {
        self.dismiss(animated: true)
    }
    @objc private func updateBtnClick() {
        self.dismiss(animated: true)
    }
    private func addsubView(){
        self.view.addSubview(contentView)
        self.contentView.addSubview(closeBtn)
        self.contentView.addSubview(resultLabel)
        self.contentView.addSubview(Img)
        self.contentView.addSubview(updateBtn)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.4)
        self.view.isOpaque = false
        self.addsubView()
        self.layout()
        self.closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        self.updateBtn.addTarget(self, action: #selector(updateBtnClick), for: .touchUpInside)

    }
}
