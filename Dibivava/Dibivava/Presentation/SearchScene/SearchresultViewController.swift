//
//  SearchresultViewController.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/19.
//

import UIKit

class SearchresultViewController: UIViewController {
    private let resultLabel = UILabel().then{
        $0.text = "해당 검색은 검색결과가 나오지 않습니다."
        $0.font = .pretendard(.Bold, size: 15)
        $0.textColor = .black
    }
    private let Img = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "noresult")
        $0.layer.masksToBounds = true
        $0.backgroundColor = .clear
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    private let closeBtn = UIButton().then{
        $0.setTitle("닫기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .pretendard(.ExtraBold, size: 15)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .mainred
    }
    private func layout(){
        self.resultLabel.snp.makeConstraints{
            $0.top.equalTo(Img.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        self.Img.snp.makeConstraints{
            $0.bottom.equalTo(closeBtn.snp.top).offset(-110)
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
    private func addsubView(){
        self.view.addSubview(contentView)
        self.contentView.addSubview(closeBtn)
        self.contentView.addSubview(resultLabel)
        self.contentView.addSubview(Img)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.4)
        self.view.isOpaque = false
        self.addsubView()
        self.layout()
        self.closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
    }
}
