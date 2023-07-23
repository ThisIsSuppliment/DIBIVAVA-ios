//
//  DetailViewController.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import UIKit
import RxSwift
import SnapKit

class SupplementDetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = UIScrollView(frame: .zero).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .systemGroupedBackground
    }
    
    private let supplementDetailView: SupplementDetailView
    private let componentView: ComponentView
    
    private var viewModel: SupplementDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(supplementDetailViewModel: SupplementDetailViewModel) {
        self.supplementDetailView = SupplementDetailView()
        self.componentView = ComponentView()
        self.viewModel = supplementDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configureSubviews()
        self.configureConstraints()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.viewWillAppear()
    }
}

private extension SupplementDetailViewController {
    func configureSubviews() {
        [supplementDetailView, componentView].forEach {
            self.scrollView.addSubview($0)
        }
        
        self.view.addSubview(scrollView)
    }
    
    func configureConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
                
        self.supplementDetailView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.top)
            make.horizontalEdges.width.equalToSuperview()
        }

        self.componentView.snp.makeConstraints { make in
            make.top.equalTo(self.supplementDetailView.snp.bottom).offset(8)
            make.horizontalEdges.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(scrollView)
            make.bottom.equalToSuperview().priority(.low)
        }
    }
    
    func bind() {
        self.viewModel.supplementDetail
            .drive(onNext: { [weak self] items in
                guard let self,
                      let items = items
                else {
                    return
                }
                
                self.supplementDetailView.nameLabel.text = items.name
                self.supplementDetailView.companyLabel.text = items.company ?? "제조사를 알수없습니다."
                self.supplementDetailView.descriptionLabel.text = (items.expireDate  ?? "제조일부터의 유통기한을 알수없습니다.") + " | " + (items.intakeMethod ?? "섭취량를 알수없습니다.")
                
                // VM으로 이동
                // 단어 후보 추가해야함
                //혈행 - 혈핵 순환, 면역기능 - 면역력
                let functionalityList = ["기억력 개선","혈행개선","간건강","체지방 감소", "갱년기여성 건강", "혈당조절", "눈건강", "면역기능", "관절/뼈건강", "전립선건강", "피로개선", "피부건강", "콜레스테롤 개선", "혈압조절", "긴장완화", "장건강", "칼슘흡수", "요로건강", "소화기능", "항산화", "혈중중성기방개선", "인지능력", "지구력항상", "치아건강", "배뇨기능 개선", "피부상태 개선", "갱년기 남성 건강", "월경전 상태 개선", "정자 운동성 개선", "여성의 질 건강", "어린이 키성장 개선"]
                
                var tmpFunctionality: [String] = []
                
                for f in items.functionality ?? [] {
                    for functionality in functionalityList{
                        if f.contains(functionality) {
                            tmpFunctionality.append(functionality)
                        }
                    }
                }
//                print(">>>>> functionality", items.functionality?.forEach({print("- " + $0 + "\n") }))
//                print(">>>>> 결과", tmpFunctionality)
                self.supplementDetailView.apply(Set(tmpFunctionality).map {String($0)})
                
                // 이미지 추가
                guard let imageURL = items.imageURL,
                      let url = URL(string: imageURL)
                else {
                    return
                }
                self.supplementDetailView.imageView.load(url: url)
            })
            .disposed(by: self.disposeBag)
        
        
        self.viewModel.component
            .drive(onNext: { [weak self] component in
                guard let self,
                      let component = component,
                      let main = component["main"],
                      let sub = component["sub"],
                      let add = component["add"]
                else {
                    return
                }
                
                let numOfMain = main == ["없음"] ? 0 : main.count
                let numOfSub = sub == ["없음"] ? 0 : sub.count
                let numOfAdd = add == ["없음"] ? 0 : add.count
                
                self.componentView.main.countLabel.text = "\(numOfMain)개"
                self.componentView.sub.countLabel.text = "\(numOfSub)개"
                self.componentView.add.countLabel.text = "\(numOfAdd)개"
                
                self.componentView.main.count = numOfMain
                self.componentView.sub.count = numOfSub
                self.componentView.add.count = numOfAdd
                
                self.componentView.applySnapshot(component)
            })
            .disposed(by: disposeBag)
    }
}


// 추후 수정
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
