//
//  MaterialCollectionViewCell.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

protocol MaterialCollectionViewCellDelegate: AnyObject {
    func showToggleButtonTapped()
}

final class MaterialCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: MaterialCollectionViewCell.self)
    
    // MARK: - UI
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 17)
    }
    
    private lazy var descriptionStackView: UIStackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.backgroundColor = .yellow
    }
    
    private lazy var allergyDescriptionView: AddictiveDescriptionView = AddictiveDescriptionView().then {
        $0.backgroundColor = .green
    }
    
    private lazy var carcinogensDescriptionView: AddictiveDescriptionView = AddictiveDescriptionView().then {
        $0.backgroundColor = .red
    }
    
    private lazy var rankLabel: BasePaddingLabel = BasePaddingLabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.font = .pretendard(.Regular, size: 15)
    }
    
    private lazy var allergyLabel: BasePaddingLabel = BasePaddingLabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.font = .pretendard(.Regular, size: 15)
        $0.backgroundColor = UIColor(rgb: 0x6785EF)
        $0.textColor = .white
        $0.text = "알레르기"
    }
    
    private lazy var termLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 12)
        $0.numberOfLines = 1
    }
    
    private lazy var chevronButton: UIButton = UIButton().then {
        $0.tintColor = .darkGray

        let normalImage = UIImage(systemName: "chevron.down")
        $0.setImage(normalImage, for: .normal)

        let selectedImage = UIImage(systemName: "chevron.up")
        $0.setImage(selectedImage, for: .selected)
    }
    
    private lazy var toggleButton: UIButton = UIButton().then {
        $0.tintColor = .clear
    }
    
    // MARK: - Properties
    
    weak var delegate: MaterialCollectionViewCellDelegate?
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var toggleOpen: Bool = false {
       didSet {
           guard self.isAddictiveMaterial
           else {
               return
           }
           self.termLabel.numberOfLines = toggleOpen ? 0 : 1
           self.chevronButton.isSelected.toggle()
           self.delegate?.showToggleButtonTapped()
           
           if toggleOpen {
               self.descriptionStackView.isHidden = false
               
               if self.allergy == 1 {
                   self.descriptionStackView.addArrangedSubview(self.allergyDescriptionView)
               }
               
               if self.level != nil && self.level != "" {
                   self.descriptionStackView.addArrangedSubview(self.carcinogensDescriptionView)
               }
               
               self.descriptionStackView.snp.remakeConstraints { make in
                   make.top.equalTo(self.termLabel.snp.bottom).offset(10)
                   make.leading.equalTo(self.titleLabel.snp.leading)
                   make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
                   make.height.greaterThanOrEqualTo(0)
                   make.bottom.equalToSuperview().inset(10)
               }
               
           } else if !toggleOpen {
               self.descriptionStackView.isHidden = true
               self.descriptionStackView.snp.remakeConstraints { make in
                   make.top.equalTo(self.termLabel.snp.bottom).offset(10)
                   make.leading.equalTo(self.titleLabel.snp.leading)
                   make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
                   make.height.equalTo(0)
                   make.bottom.equalToSuperview().inset(10)
               }
           }
       }
    }
    
    var title: String? = nil {
       didSet {
           guard let title = title else { return }
           self.titleLabel.text = title
       }
    }
    
    var terms: String? = nil {
       didSet {
           self.setAddictiveTermsLabel(terms)
       }
    }
    
    var allergyDescription: String? = nil {
       didSet {
           guard let allergyDescription = allergyDescription else { return }
           self.allergyDescriptionView.textLabel = "알르레기 유발\n" + allergyDescription
       }
    }
    
    var level: String? = nil {
        didSet {
            self.setAddictiveLevelLabel(level)
        }
     }
    
    var allergy: Int? = nil {
        didSet {
            if allergy == 0 { // allergy가 없다면
                self.allergyDescriptionView.removeFromSuperview()
                self.allergyLabel.isHidden = true
            }
        }
     }
    
    var isAddictiveMaterial: Bool = false {
       didSet {
           if !isAddictiveMaterial {
               self.allergyDescriptionView.isHidden = true
               self.chevronButton.isHidden = true
               self.termLabel.isHidden = true
               self.rankLabel.isHidden = true
               self.allergyLabel.isHidden = true
               self.termLabel.snp.removeConstraints()
               self.updateAddictiveTitleLabel()
           }
       }
    }
    
    // MARK: - Init
    
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
        self.titleLabel.text = nil
        self.rankLabel.text = nil
        self.termLabel.text = nil
        self.termLabel.numberOfLines = 1
        self.chevronButton.isHidden = false
        self.chevronButton.isSelected = false
        self.isAddictiveMaterial = false
        self.toggleOpen = false
        self.allergyDescriptionView.isHidden = true
    }
}

// MARK: - Private Method

private extension MaterialCollectionViewCell {
    func configureSubviews() {
        [titleLabel, chevronButton, allergyLabel, rankLabel, termLabel, descriptionStackView, toggleButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        
        self.chevronButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        self.allergyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
        }
      
        self.rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(self.allergyLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
        self.termLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.titleLabel.snp.leading)
            make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
        }

        self.descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(self.termLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.titleLabel.snp.leading)
            make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
            make.height.equalTo(0)
            make.bottom.equalToSuperview().inset(10)
        }
        
        self.toggleButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        self.toggleButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.toggleOpen.toggle()
            })
            .disposed(by: disposeBag)
    }
    
    func setAddictiveTermsLabel(_ terms: String?) {
        guard let terms = terms
        else {
            self.chevronButton.isHidden = true
            return
        }
        
        self.termLabel.text = terms
        self.termLabel.setLineSpacing(spacing: 4.0)
    }
    
    func setAddictiveLevelLabel(_ level: String?) {
        guard let level = level,
              level != ""
        else {
            self.rankLabel.isHidden = true
            self.updateAllergyLabel()
            return
        }
        
        self.rankLabel.text = level
        
        switch level {
        case "1":
            self.rankLabel.backgroundColor = UIColor(rgb: 0xFA6363)
        case "2A":
            self.rankLabel.backgroundColor = UIColor(rgb: 0xFFB783)
        case "2B":
            self.rankLabel.backgroundColor =  UIColor(rgb: 0xEFDA67)
        case "3":
            self.rankLabel.backgroundColor = UIColor(rgb: 0x90CA9D)
        default:
            print("알 수 없는 등급, ", level)
        }
    }
    
    func updateAddictiveTitleLabel() {
        self.titleLabel.textAlignment = .center
        
        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func updateAllergyLabel() {
        self.rankLabel.snp.removeConstraints()
        self.allergyLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
