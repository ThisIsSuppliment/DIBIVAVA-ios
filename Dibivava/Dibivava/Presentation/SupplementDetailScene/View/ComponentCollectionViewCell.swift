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

protocol ComponentCollectionViewCellDelegate: AnyObject {
    func showHideButtonTapped(_ cell: ComponentCollectionViewCell, sender: Bool)
}

final class ComponentCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: ComponentCollectionViewCell.self)
    weak var delegate: ComponentCollectionViewCellDelegate?
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
    
    let termLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
//    private let termDescriptionLabel: UILabel = UILabel().then {
//        $0.textColor = .black
//        $0.textAlignment = .left
//        $0.numberOfLines = 1
//    }
    
    private let toggleButton: UIButton = UIButton().then {
        let normalImage = UIImage(systemName: "chevron.left")
        $0.setImage(normalImage, for: .normal)

        let selectedImage = UIImage(systemName: "chevron.down")
        $0.setImage(selectedImage, for: .selected)
    }
    
    private var heightConstraint: Constraint?
    
//    private var isExpanded = false
    var isExpanded = false {
           didSet {
               termLabel.numberOfLines = isExpanded ? 0 : 1
           }
       }
    
    let disposeBag: DisposeBag = DisposeBag()

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
    
    func configure(title: String, isAdd: Bool, terms: String, level: String?) {
        self.titleLabel.text = title
        
        if isAdd {
            if let level = level {
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
                    print("알 수 없는 등급")
                }
                self.rankLabel.text = "\(level)군"
            }
            self.termLabel.text = terms + "\n222222222222222222222222222222222222222222"
//            self.termDescriptionLabel.text = "222222222222222222222222222222222222222222"
        } else if !isAdd {
            self.rankLabel.text = ""
            self.toggleButton.isHidden = true
            self.titleLabel.textAlignment = .center
            self.titleLabel.snp.updateConstraints { make in
                make.trailing.equalTo(self.rankLabel.snp.leading).offset(10)
            }
            
            self.titleLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}

private extension ComponentCollectionViewCell {
    func configureSubviews() {
        [titleLabel, toggleButton, rankLabel, termLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        heightConstraint?.deactivate()
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(self.rankLabel.snp.leading).offset(-10)
        }
        
        self.toggleButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
      
        self.rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        self.termLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.titleLabel.snp.leading)
            make.trailing.equalTo(self.toggleButton.snp.leading).offset(-10)
            make.bottom.equalToSuperview().inset(10)
        }
        
//        self.termDescriptionLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(10)
//            make.trailing.equalTo(self.toggleButton.snp.leading).inset(10)
//            make.top.equalTo(termLabel.snp.bottom).offset(10)
//            descriptionHeightConstraint = make.height.equalTo(0).constraint
//        }
        
//        self.snp.makeConstraints { make in
//            heightConstraint = make.height.equalTo(self.contentView.frame.height).constraint
//        }
    }
    
    func bind() {
        self.toggleButton.rx.tap
            .subscribe(onNext: { [weak self] in
//                self?.toggleHeight()
                guard let self else { return }
                print("tappp")
                self.isExpanded.toggle()
                self.toggleButton.isSelected.toggle()
                self.delegate?.showHideButtonTapped(self, sender: self.isExpanded)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
    
    
    
    
    
    func toggleHeight() {
        self.isExpanded.toggle()
        self.toggleButton.isSelected.toggle()
        print(self.isExpanded, self.toggleButton.isSelected)
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            guard let self = self else { return }
//            print(self.isExpanded, self.termDescriptionLabel.intrinsicContentSize.height, self.contentView.frame.height)
//
//            self.descriptionHeightConstraint?.update(offset: self.isExpanded ? self.termDescriptionLabel.intrinsicContentSize.height : 0)
//            self.heightConstraint?.update(offset: self.isExpanded ? self.termDescriptionLabel.intrinsicContentSize.height + self.contentView.frame.height : self.contentView.frame.height)
//            self.layoutIfNeeded()

            //
//            self.heightConstraint?.deactivate()
//            self.layoutIfNeeded()
//
//            self.descriptionHeightConstraint?.update(offset: self.isExpanded ? self.termDescriptionLabel.intrinsicContentSize.height : 0)
//
//            // contentView의 높이를 조정
//            self.heightConstraint?.update(offset: self.isExpanded ? self.termDescriptionLabel.intrinsicContentSize.height + 110.66666666666666 : 70)
//
//            // contentView의 높이 제약 조건을 활성화
//            self.heightConstraint?.activate()
//
//            self.layoutIfNeeded()
    }
}
