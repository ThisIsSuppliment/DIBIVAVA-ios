//
//  HomeViewController.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import UIKit
import Then
import Alamofire
import SnapKit
import ImageSlideshow

class HomeViewController: UIViewController {
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
  
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let hotLabel = UILabel().then{
        let text = "지금 뜨고있는 건강 보조제들!"
        let range = (text as NSString).range(of: "뜨고있는")
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.textColor = .black
    }
    private let bannerSlide = ImageSlideshow().then{
        $0.contentScaleMode = .scaleAspectFill
        $0.slideshowInterval = 3
    }
    private let searchbar = UISearchBar().then{
        $0.searchTextField.borderStyle = .none
        $0.searchTextField.layer.borderColor = UIColor.white.cgColor
        $0.searchBarStyle = .minimal
        $0.placeholder = "궁금한 성분이나, 식품에 대해 검색해보세요!"
        if let searchIconView = $0.searchTextField.leftView as? UIImageView {
             searchIconView.tintColor = .black
         }
    }
    private func layout(){
        self.hotLabel.snp.makeConstraints{
            $0.top.equalTo(bannerSlide.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(16)

        }
        self.searchbar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            $0.trailing.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(22)
            $0.height.equalTo(52)
        }
        self.bannerSlide.snp.makeConstraints{
            $0.top.equalTo(searchbar.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(240)

        }
    }
    private func addsubView(){
        self.view.addSubview(searchbar)
        self.view.addSubview(bannerSlide)
        self.view.addSubview(hotLabel)

    }
    private func configure(){
        self.view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubView()
        self.layout()
    }
   
}
