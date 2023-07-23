//
//  IntroViewController.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/23.
//

import UIKit
import ImageSlideshow

class IntroViewController: UIViewController {
    private let introslide = ImageSlideshow().then{
        $0.contentScaleMode = .scaleAspectFit
        $0.slideshowInterval = 5
        $0.setImageInputs([
            ImageSource(image: UIImage(named: "1p")!),
            ImageSource(image: UIImage(named: "2p")!),
            ImageSource(image: UIImage(named: "3p")!),
            ImageSource(image: UIImage(named: "4p")!),
            ImageSource(image: UIImage(named: "5p")!)
        ])    }
    private let closeBtn = UIButton().then{
        $0.backgroundColor = .clear
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .white
        $0.setTitle("닫기", for: .normal)
    }
    private func layout(){
        self.closeBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(100)
            $0.bottom.equalToSuperview().offset(-10)
        }
        self.introslide.snp.makeConstraints{
            $0.top.trailing.leading.bottom.equalToSuperview()
        }

    }
    private func addsubView(){
        self.view.addSubview(introslide)
        self.introslide.addSubview(closeBtn)
    }
    private func configure(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.6)
        self.view.isOpaque = false
        self.closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        UserDefaults.standard.setValue(true, forKey: "key")
    }
    @objc private func closeBtnClick() {
        self.dismiss(animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubView()
        self.layout()
    }
    
}
