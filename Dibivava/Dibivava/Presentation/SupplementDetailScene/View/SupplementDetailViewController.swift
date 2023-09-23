//
//  DetailViewController.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SupplementDetailViewController: UIViewController {
    // MARK: - UI
    
    private let scrollView: UIScrollView = UIScrollView(frame: .zero).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .systemGroupedBackground
    }
    
    private let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large).then {
        $0.color = .gray
        $0.backgroundColor = .white
    }
    
    private let supplementDetailView: SupplementDetailView
    private let materialView: MaterialView
    private let recommendationView: RecommendationView
    private let resourceView: ResourceView
    
    // MARK: - Properties
    
    private var viewModel: SupplementDetailViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(supplementDetailViewModel: SupplementDetailViewModel) {
        self.supplementDetailView = SupplementDetailView()
        self.materialView = MaterialView()
        self.recommendationView = RecommendationView()
        self.resourceView = ResourceView()
        self.viewModel = supplementDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - App Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureSubviews()
        self.configureConstraints()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.indicatorView.startAnimating()
        self.viewModel.viewWillAppear()
        self.navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Private Methods

private extension SupplementDetailViewController {
    func configureSubviews() {
        [supplementDetailView, materialView, recommendationView, resourceView].forEach {
            self.scrollView.addSubview($0)
        }
        
        [scrollView, indicatorView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.indicatorView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
                
        self.supplementDetailView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.top)
            make.horizontalEdges.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(300)
        }

        self.materialView.snp.makeConstraints { make in
            make.top.equalTo(self.supplementDetailView.snp.bottom).offset(7)
            make.horizontalEdges.equalToSuperview()
            make.height.greaterThanOrEqualTo(300)
        }
        
        self.recommendationView.snp.makeConstraints { make in
            make.top.equalTo(self.materialView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0)
        }
        
        self.resourceView.snp.makeConstraints { make in
            make.top.equalTo(self.recommendationView.snp.bottom).offset(7)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
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
                
                self.supplementDetailView.isGMP = items.gmpCheck
                self.supplementDetailView.imageURL = items.imageLink
                self.supplementDetailView.name = items.name
                self.supplementDetailView.company = items.company ?? "제조사 알수없음"
                self.supplementDetailView.categoryAndIntakeMethod = (items.category ?? "카테고리 알수없음") + " | " + (items.intakeMethod ?? "섭취량 알수없음")
            })
            .disposed(by: self.disposeBag)
        
        
        self.viewModel.materialByType
            .compactMap { $0 }
            .drive(onNext: { [weak self] material in
                guard let self
                else {
                    return
                }
                self.materialView.applySnapshot(material)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.isA
            .compactMap { $0 }
            .drive(onNext: { [weak self] isA in
                guard let self
                else {
                    return
                }
                self.supplementDetailView.isA = isA
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.isC
            .compactMap { $0 }
            .drive(onNext: { [weak self] isC in
                guard let self
                else {
                    return
                }
                self.supplementDetailView.isC = isC
            })
            .disposed(by: self.disposeBag)
        
        Driver.zip(self.viewModel.numOfMainMaterial, self.viewModel.numOfSubMaterial, self.viewModel.numOfAddMaterial)
            .drive(onNext: { [weak self] (numOfMain, numOfSub, numOfAdd) in
                guard let self
                else {
                    return
                }
                self.materialView.main.count = numOfMain
                self.materialView.sub.count = numOfSub
                self.materialView.add.count = numOfAdd
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.recommendSupplement
            .compactMap { $0 }
            .drive(onNext: { [weak self] recommendations in
                guard let self,
                      !recommendations.isEmpty
                else {
                    self?.recommendationView.isHidden = true
                    self?.indicatorView.stopAnimating()
                    return
                }
                
                self.recommendationView.snp.updateConstraints { make in
                    make.top.equalTo(self.materialView.snp.bottom).offset(7)
                    make.height.equalTo(280)
                }
                
                self.recommendationView.applySnapshot(recommendations)
                
                self.indicatorView.stopAnimating()
            })
            .disposed(by: self.disposeBag)
        
        self.recommendationView.itemSelected
            .drive(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.viewModel.showSelectedRecommendSupplement(with: indexPath)
            })
            .disposed(by: self.disposeBag)
    }
}
