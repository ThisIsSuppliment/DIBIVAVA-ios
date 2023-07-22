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
import RxSwift

class HomeViewController: UIViewController {
    private let HomeViewmodel = HomeViewModel()
    private var searchresult: [Supplement] = []
    private let searchAPI = SearchAPI()
    

    private let contentView = UIView().then{
        $0.backgroundColor = .white
        }
    private let scrollView = UIScrollView()
    private let searchTableview = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = .white
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(recommendCollectionViewCell.self, forCellWithReuseIdentifier: recommendCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let hotLabel = UILabel().then{
        $0.text = "지금 뜨고있는 건강기능식품들!"
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.textColor = .black
        let attributedStr = NSMutableAttributedString(string: $0.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.mainred, range: ($0.text! as NSString).range(of: "뜨고있는"))
        $0.attributedText = attributedStr

    }

    private let vitaLabel = UILabel().then{
        $0.text = "영양소들의 역할을 확인해봐요!"
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.textColor = .black
    }
    private let bannerSlide = ImageSlideshow().then{
        $0.contentScaleMode = .scaleAspectFit
        $0.slideshowInterval = 3
        $0.setImageInputs([
            ImageSource(image: UIImage(named: "s1")!),
            ImageSource(image: UIImage(named: "s2")!),
            ImageSource(image: UIImage(named: "s3")!),
            ImageSource(image: UIImage(named: "s4")!),
            ImageSource(image: UIImage(named: "s5")!)
        ])
        $0.backgroundColor = UIColor(rgb: 0xDADEDE)
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
        self.searchTableview.snp.makeConstraints{
            $0.top.equalTo(searchbar.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview()
        }
        self.vitaLabel.snp.makeConstraints{
            $0.top.equalTo(bannerSlide.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(16)
        }
        self.recommendCollectionView.snp.makeConstraints{
            $0.top.equalTo(self.vitaLabel.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(450)
        }
        self.hotLabel.snp.makeConstraints{
            $0.top.equalTo(searchbar.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(16)
        }
        self.searchbar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(22)
            $0.height.equalTo(52)
        }
        self.bannerSlide.snp.makeConstraints{
            $0.top.equalTo(hotLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(220)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(870)
        }
        
    }
    private func addsubView(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(searchbar)
        self.contentView.addSubview(bannerSlide)
        self.contentView.addSubview(hotLabel)
        self.contentView.addSubview(recommendCollectionView)
        self.contentView.addSubview(vitaLabel)
        self.contentView.addSubview(searchTableview)

    }
    private func configure(){
        self.view.backgroundColor = .white
        self.recommendCollectionView.dataSource = self
        self.recommendCollectionView.delegate = self
        self.searchbar.delegate = self
        self.searchTableview.delegate = self
        self.searchTableview.dataSource = self
        self.searchTableview.isHidden = true
        setupHideKeyboardOnTap()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubView()
        self.layout()
    
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendCollectionViewCell.identifier, for: indexPath) as! recommendCollectionViewCell
        let image = HomeViewmodel.supplementImg(indexPath: indexPath.row)
        cell.Img.image = image
        cell.innerLabel.text = HomeViewmodel.supplementEng(indexPath: indexPath.row)
        cell.nameLabel.text = HomeViewmodel.supplementKor(indexPath: indexPath.row)
        cell.innerLabel.textColor = HomeViewmodel.supplementColor(indexPath: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 3.1
            let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 3.2
                return CGSize(width: cellWidth, height: cellHeight)
            }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popup = PopUpViewController()
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve
        popup.infoLabel.text = HomeViewmodel.supplementdes(indexPath: indexPath.row)
        popup.nameLabel.text = HomeViewmodel.supplementKor(indexPath: indexPath.row)
        popup.recommaneLabel.text = HomeViewmodel.supplementre(indexPath: indexPath.row)! + " 많이 들어있는 건강기능식품들"
        let attributedStr = NSMutableAttributedString(string: popup.recommaneLabel.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.mainred, range: (popup.recommaneLabel.text! as NSString).range(of: "많이"))
        popup.recommaneLabel.attributedText = attributedStr
        popup.getId = HomeViewmodel.supplementId(indexPath: indexPath.row)!
        print(HomeViewmodel.supplementId(indexPath: indexPath.row)!)
        self.present(popup,animated: true,completion: nil)
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.text = ""
        let popup = SearchresultViewController()
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve
        self.present(popup,animated: true,completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
        self.searchTableview.isHidden = true
        }else{
            self.searchAPI.getSearchResult(name: searchText) { response in
                switch response {
                case .success(let searchresponse):
                    self.searchresult = searchresponse
                    self.searchTableview.reloadData()
                    if self.searchresult.count == 0 {
                        self.searchTableview.isHidden = true
                    }
                    else{
                        self.searchTableview.isHidden = false
                    }
                case .failure(let error):
                    print("/search 오류:\(error)")
                }
            }
        }
        }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchresult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.nameLabel.text = searchresult[indexPath.row].name
        cell.companyLabel.text = "[" + searchresult[indexPath.row].company + "]"
        cell.suplementId = searchresult[indexPath.row].supplementId
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        // 화면 전환
        self.searchAPI.getSupplementID(id: searchresult[indexPath.row].supplementId) { response in
            print(response)
        }
        let vc = SupplementDetailViewController(supplementDetailViewModel: DefaultSupplementDetailViewModel(
            id:searchresult[indexPath.row].supplementId ,
            supplementNetworkService: DefaultSupplementNetworkService())
        )
//        present(vc, animated: false)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension HomeViewController {
    // ViewController에서 해당 함수 실행
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    // 다른곳에서는 쓸 일이 없으므로 private
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
//
//self.searchAPI.getSupplementID(id: searchresult[indexPath.row].supplementId) { response in
//          print(response)
//      }
//     let vc = SupplementDetailViewController(supplementDetailViewModel: DefaultSupplementDetailViewModel(
//          id:searchresult[indexPath.row].supplementId , supplementNetworkService: DefaultSupplementNetworkService()))
//      present(vc, animated: false)
