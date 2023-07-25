//
//  ComponentCollectionViewCell.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class ComponentCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: ComponentCollectionViewCell.self)
    
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private let rankLabel: BasePaddingLabel = BasePaddingLabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.25
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let termLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
//    private let termDescriptionLabel: UILabel = UILabel().then {
//        $0.textColor = .black
//        $0.textAlignment = .left
//        $0.numberOfLines = 0
//    }
    
//    private let toggleButton: UIButton = UIButton().then {
//        let normalImage = UIImage(systemName: "chevron.left")
//        $0.setImage(normalImage, for: .normal)
//
//        let selectedImage = UIImage(systemName: "chevron.down")
//        $0.setImage(selectedImage, for: .selected)
//    }
    
    private var heightConstraint: Constraint?
    private var isExpanded = false
    
    private let toggleButtonTapRelay = PublishRelay<Void>()
    let disposeBag: DisposeBag = DisposeBag()
    var toggleButtonTapped: ControlEvent<Void> {
        return ControlEvent(events: toggleButtonTapRelay.asObservable())
    }
    private var descriptionHeightConstraint: Constraint?
    private let heightChangedSubject = PublishSubject<CGFloat>()
    
    var heightChanged: Observable<CGFloat> {
        return heightChangedSubject.asObservable()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.25
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        self.configureSubviews()
        self.configureConstraints()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.rankLabel.text = ""
        self.termLabel.text = ""
//        self.termDescriptionLabel.text = ""
        self.isExpanded = false
        self.titleLabel.textAlignment = .left
        self.heightConstraint = nil
    }
    
    func configure(title: String, isAdd: Bool, terms: String) {
        print(title, isAdd, terms)
        self.titleLabel.text = title
        
        if isAdd {
            self.rankLabel.text = "2-B"
            self.termLabel.text = terms
//            self.termDescriptionLabel.text = "########################################### \n 222222222222222222222222222222222222222222"
        } else if !isAdd {
            self.rankLabel.text = ""
//            self.toggleButton.isHidden = true
//            self.titleLabel.snp.updateConstraints { make in
//                make.trailing.equalTo(self.rankLabel.snp.leading).offset(10)
//            }
            self.titleLabel.textAlignment = .center
            
            self.titleLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}

private extension ComponentCollectionViewCell {
    func configureSubviews() {
//        [titleLabel, toggleButton, rankLabel, termLabel, termDescriptionLabel].forEach {
//            self.contentView.addSubview($0)
//        }
        [titleLabel, rankLabel, termLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(self.rankLabel.snp.leading).offset(-10)
        }
        
//        self.toggleButton.snp.makeConstraints { make in
//            make.size.equalTo(50)
//            make.centerY.equalTo(self.termLabel.snp.centerY)
//            make.trailing.equalToSuperview()
//        }
      
        self.rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        self.termLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.titleLabel.snp.leading)
//            make.trailing.equalTo(self.toggleButton.snp.leading).offset(-20)
            make.trailing.equalToSuperview().inset(10)
//            make.height.equalTo(self.termLabel.intrinsicContentSize.height)
        }
        
//        self.termDescriptionLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(10)
//            make.top.equalTo(termLabel.snp.bottom).offset(10)
//            make.bottom.equalToSuperview().inset(10)
//            descriptionHeightConstraint = make.height.equalTo(0).constraint
//        }
    }
    
    func bind() {
//        self.toggleButton.rx.tap
//            .bind(to: toggleButtonTapRelay)
//            .disposed(by: disposeBag)
        
//        self.toggleButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                self?.toggleHeight()
//            })
//            .disposed(by: disposeBag)
    }
    
    func toggleHeight() {
//        print("++ toggleHeight")
//        isExpanded.toggle()
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            guard let self = self else { return }
////                self.snp.updateConstraints { make in
////                    make.height.equalTo(self.isExpanded ? 140 : 70)
////                }
//
//            self.descriptionHeightConstraint?.update(offset: self.isExpanded ? self.termDescriptionLabel.intrinsicContentSize.height : 0)
//            self.contentView.layoutIfNeeded()
//        }
    }
}
