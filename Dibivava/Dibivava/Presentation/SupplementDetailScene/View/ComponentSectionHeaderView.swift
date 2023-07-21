//
//  ComponentSectionHeaderView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/19.
//

import UIKit

import SnapKit
import Then

final class ComponentSectionHeaderView: UICollectionReusableView {
    static let identifier: String = String(describing: ComponentSectionHeaderView.self)
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private lazy var countLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview()
        self.configureConstraints()
        
//        self.backgroundColor = .blue // 추후 삭제
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
    
    func configure(title: String, count: Int) {
        self.titleLabel.text = title
        self.countLabel.text = "\(count) 개"
    }
    
    private func addSubview() {
        [titleLabel, countLabel].forEach {
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
