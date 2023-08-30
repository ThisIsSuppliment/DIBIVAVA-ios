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
    
    private let rankLabel: BasePaddingLabel = BasePaddingLabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.font = .pretendard(.Regular, size: 15)
    }
    
    private let termLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.Regular, size: 12)
        $0.numberOfLines = 1
    }
    
    private let chevronButton: UIButton = UIButton().then {
        $0.tintColor = .darkGray

        let normalImage = UIImage(systemName: "chevron.down")
        $0.setImage(normalImage, for: .normal)

        let selectedImage = UIImage(systemName: "chevron.up")
        $0.setImage(selectedImage, for: .selected)
    }
    
    private let toggleButton: UIButton = UIButton().then {
        $0.tintColor = .clear
    }
    
    // MARK: - Properties
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var isToggle: Bool = false {
       didSet {
           self.termLabel.numberOfLines = isToggle ? 0 : 1
           self.chevronButton.isSelected.toggle()
           self.delegate?.showToggleButtonTapped()
       }
    }
    
    weak var delegate: MaterialCollectionViewCellDelegate?
    
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
    
    var level: String? = nil {
        didSet {
            self.setAddictiveLevelLabel(level)
        }
     }
    
    var isAddictiveMaterial: Bool = true {
       didSet {
           if !isAddictiveMaterial {
               self.chevronButton.isHidden = true
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
        self.titleLabel.text = ""
        self.rankLabel.text = ""
        self.termLabel.text = ""
        self.chevronButton.isHidden = false
        self.chevronButton.isSelected = false
    }
}

// MARK: - Private Method

private extension MaterialCollectionViewCell {
    func configureSubviews() {
        [titleLabel, chevronButton, rankLabel, termLabel, toggleButton].forEach {
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
      
        self.rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(self.titleLabel.snp.trailing)
            make.trailing.equalTo(self.chevronButton.snp.trailing)
        }
        
        self.termLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.titleLabel.snp.leading)
            make.trailing.equalTo(self.chevronButton.snp.leading).offset(-15)
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
                self.isToggle.toggle()
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
        guard let level = level
        else {
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
            print("알 수 없는 등급")
        }
    }
    
    func updateAddictiveTitleLabel() {
        self.titleLabel.textAlignment = .center
        
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
