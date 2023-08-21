//
//  MaterialSectionHeaderView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

import SnapKit
import Then

final class MaterialSectionHeaderView: UICollectionReusableView {
    static let identifier: String = String(describing: MaterialSectionHeaderView.self)
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .pretendard(.SemiBold, size: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview()
        self.configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
    private func addSubview() {
        [titleLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
