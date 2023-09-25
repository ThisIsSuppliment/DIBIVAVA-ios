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
    
    private let nameLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 17)
    }
    
    private lazy var descriptionStackView: UIStackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.backgroundColor = .lightGray
        $0.isHidden = true
    }
    
    private lazy var allergyDescriptionView: AddictiveDescriptionView = AddictiveDescriptionView(labelImageViewType: .allergy(isSelected: true))
    
    private lazy var carcinogensDescriptionView: AddictiveDescriptionView = AddictiveDescriptionView(labelImageViewType: .carcinogens(isSelected: true))
    
    private lazy var iarcGroupImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: LabelImageViewType.carcinogens(isSelected: true).imageName)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var allergyImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: LabelImageViewType.allergy(isSelected: true).imageName)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var termLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 12)
        $0.numberOfLines = 1
        $0.setLineSpacing(spacing: 0.4)
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
           self.descriptionStackView.isHidden = toggleOpen ? false : true
           self.delegate?.showToggleButtonTapped()
           
           self.descriptionStackView.snp.remakeConstraints { make in
               make.top.equalTo(self.termLabel.snp.bottom).offset(10)
               make.leading.equalTo(self.nameLabel.snp.leading)
               make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
               if toggleOpen {
                   make.height.greaterThanOrEqualTo(0)
               } else if !toggleOpen {
                   make.height.equalTo(0)
               }
               make.bottom.equalToSuperview().inset(10)
           }
       }
    }
    
    var name: String? = nil {
       didSet {
           guard let name = name else { return }
           self.nameLabel.text = name
       }
    }
    
    var terms: String? = nil {
       didSet {
           guard let terms = terms
           else {
               self.chevronButton.isHidden = true
               return
           }
           
           self.termLabel.text = terms
       }
    }
    
    var allergyDescription: String? = nil {
       didSet {
           guard let allergyDescription = allergyDescription else { return }
           self.allergyDescriptionView.textLabel = "\n알레르기 유발\n\(allergyDescription)\n"
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
                self.allergyImageView.isHidden = true
            } else if allergy == 1 { // allergy가 있다면
                self.descriptionStackView.addArrangedSubview(self.allergyDescriptionView)
            }
        }
     }
    
    var isAddictiveMaterial: Bool = false {
       didSet {
           if !isAddictiveMaterial {
               self.allergyDescriptionView.isHidden = true
               self.chevronButton.isHidden = true
               self.termLabel.isHidden = true
               self.iarcGroupImageView.isHidden = true
               self.allergyImageView.isHidden = true
               self.termLabel.snp.removeConstraints()
               self.updateNameLabelWhenItsNotAddictive()
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
        self.nameLabel.text = nil
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
        [nameLabel, chevronButton, allergyImageView, iarcGroupImageView, termLabel, descriptionStackView, toggleButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        
        self.chevronButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        self.allergyImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.nameLabel)
        }
      
        self.iarcGroupImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.nameLabel)
            make.leading.equalTo(self.allergyImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
        self.termLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.nameLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.nameLabel.snp.leading)
            make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
        }

        self.descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(self.termLabel.snp.bottom)
            make.leading.equalTo(self.nameLabel.snp.leading)
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
    
    func setAddictiveLevelLabel(_ level: String?) {
        guard let level = level,
              level != ""
        else {
            self.iarcGroupImageView.isHidden = true
            self.updateAllergyLabelConstraints()
            return
        }
        
        let iarcGroupDescription = IarcGroup(rawValue: level)?.description ?? ""
        self.carcinogensDescriptionView.textLabel = "\nWHO IARC 등급: \(level)\n\(iarcGroupDescription)\n"
        self.descriptionStackView.addArrangedSubview(self.carcinogensDescriptionView)
    }
    
    func updateNameLabelWhenItsNotAddictive() {
        self.nameLabel.textAlignment = .center
        
        self.nameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func updateAllergyLabelConstraints() {
        self.iarcGroupImageView.snp.removeConstraints()
        self.allergyImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
