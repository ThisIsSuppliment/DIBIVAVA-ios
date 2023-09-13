//
//  FunctionalityCollectionViewCell.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

final class FunctionalityCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: FunctionalityCollectionViewCell.self)
    
    // MARK: - UI
    
    private let titleLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.25
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true
        
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String? = nil {
        didSet {
            guard let title = title
            else {
                return
            }
            self.titleLabel.text = title
        }
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = ""
    }
}

private extension FunctionalityCollectionViewCell {
    func configureSubviews() {
        [titleLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}
