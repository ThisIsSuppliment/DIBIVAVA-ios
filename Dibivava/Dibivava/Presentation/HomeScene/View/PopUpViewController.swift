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
    public var listLabel = UILabel().then{
        $0.text = "blashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqeblashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqeblashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqe"
        $0.font = .pretendard(.Bold, size: 15)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    public var nameLabel = UILabel().then{
        $0.text = "비타민 A란?"
        $0.font = .pretendard(.ExtraBold, size: 18)
        $0.textColor = .darkGray
    }
    public var infoLabel = UILabel().then{
        $0.text = "blashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqeblashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqeblashasdasdasdasdasdasdasdasdasdasdwqeqwewqewqeqweqweqwewqe"
        $0.font = .pretendard(.Light, size: 15)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    public var recommaneLabel = UILabel().then{
        $0.text = "비타민 A가 많이 들어있는 보조제들!"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = .darkGray
    }
    private let closeBtn = UIButton().then{
        $0.setTitle("닫기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .pretendard(.ExtraBold, size: 15)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .mainred
    }
    private func layout(){
        self.listLabel.snp.makeConstraints{
            $0.top.equalTo(recommaneLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-10)
        }
        self.infoLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-10)

        }
        self.recommaneLabel.snp.makeConstraints{
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(22)
        }
        self.closeBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-19)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(48)
        }
        self.contentView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(370)
            $0.width.equalTo(300)

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
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(listLabel)

    }
    private func configure(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.4)
        self.view.isOpaque = false
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
