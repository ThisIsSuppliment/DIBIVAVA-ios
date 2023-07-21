//
//  SearchTableViewCell.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    public var companyLabel = UILabel().then{
        $0.text = "회사"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.font = .pretendard(.Regular, size: 14)
    }
    public var nameLabel = UILabel().then{
        $0.text = "이름"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.font = .pretendard(.Regular, size: 14)
    }
    private func layout(){
        self.companyLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nameLabel.snp.trailing).offset(10)

        }
        self.nameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }
    private func addsubview() {
        self.addSubview(companyLabel)
        self.addSubview(nameLabel)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addsubview()
        self.layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
