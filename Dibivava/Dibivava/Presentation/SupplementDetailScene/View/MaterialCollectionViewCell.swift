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
    func updateHeightWhenToggle()
}

final class MaterialCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: MaterialCollectionViewCell.self)
    
    // MARK: - UI
    
    private let nameLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
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
           guard self.isAddictiveMaterial else { return }
           
           self.termLabel.numberOfLines = toggleOpen ? 0 : 1
           self.chevronButton.isSelected.toggle()
           self.descriptionStackView.isHidden = toggleOpen ? false : true
           self.delegate?.updateHeightWhenToggle()
           self.configureDescriptionStackViewConstraints()
       }
    }
    
    var isAddictiveMaterial: Bool = false {
       didSet {
           self.configureSubviews(by: isAddictiveMaterial)
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
           guard let terms = terms else { return }
           self.termLabel.text = terms
       }
    }
    
    var allergyDescription: String? = nil {
       didSet {
           guard let allergyDescription = allergyDescription else { return }
           
           self.contentView.addSubview(self.allergyImageView)
           self.allergyImageView.snp.makeConstraints { make in
               make.centerY.equalTo(self.nameLabel)
               if iarcGroup != nil && iarcGroup != "" {
                   make.trailing.equalTo(self.iarcGroupImageView.snp.leading).offset(-5)
               } else {
                   make.trailing.equalToSuperview().inset(10)
               }
           }
           
           self.allergyDescriptionView.textLabel = "\n알레르기 유발\n\(allergyDescription)\n"
           self.descriptionStackView.addArrangedSubview(self.allergyDescriptionView)
       }
    }
    
    var iarcGroup: String? = nil {
        didSet {
            guard let iarcGroup = iarcGroup,
                  iarcGroup != ""
            else {
                return
            }
            
            self.contentView.addSubview(self.iarcGroupImageView)
            self.iarcGroupImageView.snp.makeConstraints { make in
                make.centerY.equalTo(self.nameLabel)
                if self.allergyDescription != nil { // allergy가 있다면
                    make.trailing.equalTo(self.allergyImageView.snp.leading).offset(-5)
                } else {
                    make.trailing.equalToSuperview().inset(10)
                }
            }
            
            let iarcGroupDescription = IarcGroup(rawValue: iarcGroup)?.description ?? ""
            self.carcinogensDescriptionView.textLabel = "\nWHO IARC 등급: \(iarcGroup)\n\(iarcGroupDescription)\n"
            self.descriptionStackView.addArrangedSubview(self.carcinogensDescriptionView)
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
        self.name = nil
        self.terms = nil
        self.allergyDescription = nil
        self.iarcGroup = nil
    }
}

// MARK: - Private Method

private extension MaterialCollectionViewCell {
    func configureSubviews() {
        [nameLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func configureSubviews(by isAddictiveMaterial: Bool) {
        if isAddictiveMaterial {
            [termLabel, chevronButton, toggleButton, descriptionStackView].forEach {
                self.contentView.addSubview($0)
            }
            
            self.nameLabel.snp.remakeConstraints { make in
                make.top.left.equalToSuperview().inset(10)
            }
            
            self.termLabel.snp.makeConstraints { make in
                make.top.greaterThanOrEqualTo(self.nameLabel.snp.bottom).offset(20)
                make.leading.equalTo(self.nameLabel.snp.leading)
                make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
            }
            
            self.chevronButton.snp.makeConstraints { make in
                make.size.equalTo(20)
                make.trailing.equalToSuperview().inset(10)
                make.bottom.equalToSuperview().inset(10)
            }
            
            self.toggleButton.snp.makeConstraints { make in
                make.top.horizontalEdges.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
            self.descriptionStackView.snp.makeConstraints { make in
                make.top.equalTo(self.termLabel.snp.bottom)
                make.leading.equalTo(self.nameLabel.snp.leading)
                make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
                make.height.equalTo(0)
                make.bottom.equalToSuperview().inset(10)
            }
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
    
    func configureDescriptionStackViewConstraints() {
        self.descriptionStackView.snp.remakeConstraints { make in
            make.top.equalTo(self.termLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.nameLabel.snp.leading)
            make.trailing.equalTo(self.chevronButton.snp.leading).offset(-10)
            if self.toggleOpen {
                make.height.greaterThanOrEqualTo(0)
            } else if !self.toggleOpen {
                make.height.equalTo(0)
            }
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
