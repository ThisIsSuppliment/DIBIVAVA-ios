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
import SafeAreaBrush
import Kingfisher

class HomeViewController: UIViewController {
    private let HomeViewmodel = HomeViewModel()
    private var searchresult: [Supplement] = []
    private var searchInfo: [SupplementResponse] = []
    private let searchAPI = SearchAPI()
    private let warningLabel = UILabel().then{
        $0.text = "- [성분 정보 출저] 건강기능식품: 식품안전나라/ 건강기능식품 품목제조신고(원재료), 건강기능식품 기능성원료인정현황,  Ames, Bruce N; Gold, Lois Swirsky (2000).  “Paracelsus to parascience: The environmental cancer distraction”.  《Mutation Research/Fundamental and Molecular Mechanisms of Mutagenesis》 447: 3 - 본 정보는 참고용으로, 법적 책임을 지지 않습니다. - 본 정보는 참고용으로만 제공되며 개별적인 상황에 따라 반드시 의료전문가와 상담하여야합니다.어떠한 경우에도 본 앱의 내용을 근거로 한 자체 진단 또는                 치료를 시도해서는 안됩니다."
        $0.font = .pretendard(.Light, size: 12)
        $0.textColor = UIColor(rgb: 0x878787)
        $0.numberOfLines = 0
    }
    private let warningView = UIView().then{
        $0.backgroundColor = UIColor(rgb: 0xE5ECEC)
    }
    private let searhbarSV = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fill
        $0.backgroundColor = .clear
    }
    private let logoImgView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = .clear
        $0.image = UIImage(named:"ㄲㄲㅃㅃ")
    }
    private let topView = UIView().then{
        $0.backgroundColor = UIColor(rgb: 0xE5ECEC)
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(rgb: 0xE5ECEC)
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
        }
    private let scrollView = UIScrollView()
    private let searchTableview = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.4)
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(recommendCollectionViewCell.self, forCellWithReuseIdentifier: recommendCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    private let hotLabel = UILabel().then{
        $0.text = "WHO IARC 발암유발물질 기준"
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.textColor = UIColor(rgb: 0x666666)
        let attributedStr = NSMutableAttributedString(string: $0.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.mainred, range: ($0.text! as NSString).range(of: "발암유발물질"))
        $0.attributedText = attributedStr

    }
    private let searchbar = UISearchBar().then{
        $0.searchTextField.borderStyle = .none
        $0.searchTextField.layer.borderColor = UIColor.white.cgColor
        $0.searchBarStyle = .minimal
        $0.placeholder = "섭취하시는 영양제에 대해 검색해보세요!"
        if let searchIconView = $0.searchTextField.leftView as? UIImageView {
             searchIconView.tintColor = .black
         }
        $0.backgroundColor = .white
         $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)

    }
    private func layout(){
        self.warningLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        self.warningView.snp.makeConstraints{
            $0.top.equalTo(recommendCollectionView.snp.bottom).offset(0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        self.searhbarSV.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(0)
        }
        self.logoImgView.snp.makeConstraints{
            $0.height.equalTo(70)
        }
        self.topView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(125)
        }
        self.searchTableview.snp.makeConstraints{
            $0.leading.bottom.trailing.equalToSuperview().offset(0)
            $0.top.equalTo(searchbar.snp.bottom)
        }
        self.recommendCollectionView.snp.makeConstraints{
            $0.top.equalTo(self.hotLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(600)
        }
        self.hotLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(16)
        }
        self.searchbar.snp.makeConstraints{
            $0.height.equalTo(42)
        }

        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
        self.contentView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(820)
        }
        
    }
    private func addsubView(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(hotLabel)
        self.contentView.addSubview(recommendCollectionView)
        self.view.addSubview(topView)
        self.searhbarSV.addArrangedSubview(logoImgView)
        self.searhbarSV.addArrangedSubview(searchbar)
        self.view.addSubview(searchTableview)
        self.topView.addSubview(searhbarSV)
        self.searchTableview.bringSubviewToFront(self.view)
        self.contentView.addSubview(warningView)
        self.warningView.addSubview(warningLabel)
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
       fillSafeArea(position: .top, color: UIColor(rgb: 0xE5ECEC))
        self.navigationController?.navigationBar.isHidden = true
        fillSafeArea(position: .bottom, color: UIColor(rgb: 0xE5ECEC))

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubView()
        self.layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "key") != true {
            let vc = IntroViewController()
             vc.modalPresentationStyle = .overFullScreen
             self.present(vc,animated: false,completion: nil)
        }
        self.searchAPI.getSearchResult(name: "D",limit: 0) { response in
            switch response {
            case .success(_):
                print("깨움")
            case .failure(let error):
                print("/search 오류:\(error)")
            }
        }
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendCollectionViewCell.identifier, for: indexPath) as! recommendCollectionViewCell
        let image = HomeViewmodel.supplementImg(indexPath: indexPath.row)
        cell.Img.image = image
        cell.nameLabel.text = HomeViewmodel.supplementKor(indexPath: indexPath.row)
        cell.roundview.backgroundColor = HomeViewmodel.supplementColor(indexPath: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 1
            let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 4.1
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
        popup.recommaneLabel.text = HomeViewmodel.supplementre(indexPath: indexPath.row)! + " 지정된 첨가제들!"
        popup.listLabel.text = HomeViewmodel.supplementEng(indexPath: indexPath.row)
        let attributedStr = NSMutableAttributedString(string: popup.recommaneLabel.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.mainred, range: (popup.recommaneLabel.text! as NSString).range(of: "지정된"))
        popup.recommaneLabel.attributedText = attributedStr
        self.present(popup,animated: true,completion: nil)
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.searchbar.text == ""{
            let popup = SearchresultViewController()
            popup.modalPresentationStyle = .overFullScreen
            popup.modalTransitionStyle = .crossDissolve
            self.present(popup,animated: true,completion: nil)
        }
        else
        {
            self.searchAPI.getSupplementName(name: self.searchbar.text ?? "") { response in
                switch response {
                case .success(let searchresponse):
                    let vc = SupplementDetailViewController(supplementDetailViewModel: DefaultSupplementDetailViewModel(
                        id:searchresponse.result.supplementID ,
                        supplementNetworkService: DefaultSupplementNetworkService())
                    )
                    self.navigationController?.navigationBar.tintColor = UIColor.black
                    self.navigationController?.navigationBar.topItem?.title = ""
                    self.searchTableview.isHidden = true
                    self.topView.backgroundColor = UIColor(rgb: 0xE5ECEC)
                    self.fillSafeArea(position: .top, color: UIColor(rgb: 0xE5ECEC))
                    self.logoImgView.isHidden = false
                    self.searchbar.text = ""
                    self.navigationController?.pushViewController(vc, animated: false)
                case .failure(let error):
                    print("/name 오류:\(error)")
                }
            }
        }
        if self.searchresult.count == 0 {
            self.searchbar.text = ""
            let popup = SearchresultViewController()
            popup.modalPresentationStyle = .overFullScreen
            popup.modalTransitionStyle = .crossDissolve
            self.present(popup,animated: true,completion: nil)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
        self.searchTableview.isHidden = true
            self.topView.backgroundColor = UIColor(rgb: 0xE5ECEC)
                self.fillSafeArea(position: .top, color: UIColor(rgb: 0xE5ECEC))
                self.logoImgView.isHidden = false
                

        }else{
            self.searchAPI.getSearchResult(name: searchText,limit: 10) { response in
                switch response {
                case .success(let searchresponse):
                    self.searchresult = searchresponse
                    self.searchTableview.reloadData()
                    if self.searchresult.count == 0 {
                        self.searchTableview.isHidden = true
                        self.topView.backgroundColor = UIColor(rgb: 0xE5ECEC)
                        self.fillSafeArea(position: .top, color: UIColor(rgb: 0xE5ECEC))
                        self.logoImgView.isHidden = false

                    }
                    else{
                        self.searchTableview.isHidden = false
                        self.topView.backgroundColor = .white
                        self.fillSafeArea(position: .top, color:.white)
                        self.logoImgView.isHidden = true
        
                    }
                case .failure:
                    self.searchTableview.isHidden = true
                    self.topView.backgroundColor = UIColor(rgb: 0xE5ECEC)
                    self.fillSafeArea(position: .top, color: UIColor(rgb: 0xE5ECEC))
                    self.logoImgView.isHidden = false
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
        // 화면 전환
        let vc = SupplementDetailViewController(supplementDetailViewModel: DefaultSupplementDetailViewModel(
            id:searchresult[indexPath.row].supplementId ,
            supplementNetworkService: DefaultSupplementNetworkService())
        )
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.searchTableview.isHidden = true
        self.topView.backgroundColor = UIColor(rgb: 0xE5ECEC)
        self.fillSafeArea(position: .top, color: UIColor(rgb: 0xE5ECEC))
        self.logoImgView.isHidden = false
        self.searchbar.text = ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
