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
    func showHideButtonTapped(_ cell: MaterialCollectionViewCell, sender: Bool)
}

final class MaterialCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: MaterialCollectionViewCell.self)
    
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
    
    private let toggleButton: UIButton = UIButton().then {
        $0.tintColor = .darkGray

        let normalImage = UIImage(systemName: "chevron.down")
        $0.setImage(normalImage, for: .normal)

        let selectedImage = UIImage(systemName: "chevron.up")
        $0.setImage(selectedImage, for: .selected)
    }
    
    weak var delegate: MaterialCollectionViewCellDelegate?
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    var isExpanded = false {
       didSet {
           termLabel.numberOfLines = isExpanded ? 0 : 1
       }
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
        self.toggleButton.isSelected = false
        self.isExpanded = false
    }
    
    func configure(title: String, isAdd: Bool, terms: String, level: String?) {
        self.titleLabel.text = title
        
        if isAdd {
            if let level = level {
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
            self.toggleButton.isHidden = false
            self.termLabel.text = terms
            self.termLabel.setLineSpacing(spacing: 4.0)
        } else if !isAdd {
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

private extension MaterialCollectionViewCell {
    func configureSubviews() {
        [titleLabel, toggleButton, rankLabel, termLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
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
            make.trailing.equalTo(self.toggleButton.snp.trailing)
        }
        
        self.termLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.titleLabel.snp.leading)
            make.trailing.equalTo(self.toggleButton.snp.leading).offset(-15)
            make.bottom.equalToSuperview().inset(10).priority(.low)
        }
    }
    
    func bind() {
        self.toggleButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.toggleHeight()
            })
            .disposed(by: disposeBag)
    }

    func toggleHeight() {
        self.isExpanded.toggle()
        self.toggleButton.isSelected.toggle()
        self.delegate?.showHideButtonTapped(self, sender: self.isExpanded)
    }
}