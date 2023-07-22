//
//  PopUpViewController.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/19.
//

import UIKit
import Kingfisher
import RxSwift
import Alamofire

class PopUpViewController: UIViewController {
    public var getId:[Int] = []
    private let sapi = SearchAPI()
  
    private let contentView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    public var nameLabel = UILabel().then{
        $0.text = "비타민 A란?"
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.textColor = .black
    }
    public var infoLabel = UILabel().then{
        $0.text = "blashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqeblashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqeblashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqe"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    public var recommaneLabel = UILabel().then{
        $0.text = "비타민 A가 많이 들어있는 보조제들!"
        $0.font = .pretendard(.ExtraBold, size: 15)
        $0.textColor = .black
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
    private let closeBtn = UIButton().then{
        $0.setTitle("닫기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .pretendard(.ExtraBold, size: 15)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .mainred
    }
    private func layout(){
        self.infoLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-10)

        }
        self.recommaneLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(235)
            $0.leading.equalToSuperview().offset(22)
        }
        self.recommendCollectionView.snp.makeConstraints{
            $0.top.equalTo(recommaneLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(150)
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
            $0.width.equalTo(350)

        }
        self.nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    private func addsubView(){
        self.view.addSubview(contentView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(closeBtn)
        self.contentView.addSubview(recommaneLabel)
        self.contentView.addSubview(recommendCollectionView)
        self.contentView.addSubview(infoLabel)
    }
    private func configure(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.4)
        self.view.isOpaque = false
        self.recommendCollectionView.delegate = self
        self.recommendCollectionView.dataSource = self
        self.closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
    }
    @objc private func closeBtnClick() {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubView()
        self.layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func downloadAndResizeImage(from urlString: String, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    let resizedImage = self.resizeImage(image: image, targetSize: targetSize)
                    completion(resizedImage)
                } else {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
extension PopUpViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendCollectionViewCell.identifier, for: indexPath) as! recommendCollectionViewCell
        cell.innerLabel.isHidden = true
        self.sapi.getSupplementID(id: self.getId[indexPath.row]) { response in
            switch response {
            case .success(let searchresponse):
                cell.nameLabel.font = .pretendard(.Light, size: 7)
                cell.nameLabel.text = searchresponse.result.name
                let url = URL(string: searchresponse.result.imageURL!)
                cell.Img.contentMode = .scaleAspectFit
                cell.Img.kf.setImage(with:url)
            case .failure(let error):
                print("/search 오류:\(error)")
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 3.1
            let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 1
            return CGSize(width: cellWidth, height: cellHeight)
            }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}
