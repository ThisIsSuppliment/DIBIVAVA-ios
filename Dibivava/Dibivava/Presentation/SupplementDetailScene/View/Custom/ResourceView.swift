//
//  ResourceView.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/13.
//

import UIKit

final class ResourceView: UIView {
    
    let medicalDisclaimerLabel: UILabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .pretendard(.Light, size: 12)
        $0.textColor = UIColor(rgb: 0x878787)
        $0.numberOfLines = 0
        $0.text = "[주의사항]\n- 본 정보는 참고용으로, 법적 책임을 지지 않습니다.\n- 본 정보는 참고용으로만 제공되며 개별적인 상황에 따라 반드시 의료 전문가와 상담하여야 합니다. 어떠한 경우에도 본 앱의 내용을 근거로 한 자체 진단 또는 치료를 시도해서는 안 됩니다."
    }
    
    let supplementResourceLabel: UITextView = UITextView().then {
        $0.textAlignment = .left
        $0.font = .pretendard(.Light, size: 12)
        $0.textColor = UIColor(rgb: 0x878787)
        $0.text = "[정보 출처]\n- 건강기능식품, 건강기능식품 품목제조신고(원재료), 건강기능식품 기능성원료인정현황, 건강기능식품 개별인정형 정보, 식품첨가물의기준및규격, 건강기능식품GMP 지정 현황: 식품의약품안전처[https://www.foodsafetykorea.go.kr/]\n- 생리활성기능: 질병관리청 국가건강정보포털[https://health.kdca.go.kr/]"
        $0.isEditable = false
        $0.isSelectable = true
        $0.isScrollEnabled = false
        $0.dataDetectorTypes = .link
        $0.textContainer.maximumNumberOfLines = 0
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.configureSubView()
        self.configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension ResourceView {
    func configureSubView() {
        [supplementResourceLabel, medicalDisclaimerLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.supplementResourceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }
        
        self.medicalDisclaimerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.supplementResourceLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}
