//
//  HomeSupplement.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/19.
//

import Foundation
import UIKit

enum supplementImg: Int{
    case Supplement1 = 0
    case Supplement2 = 1
    case Supplement3 = 2
    case Supplement4 = 3
    case Supplement5 = 4
    case Supplement6 = 5
    case Supplement7 = 6
    case Supplement8 = 7
    case Supplement9 = 8
    
    var image: UIImage {
        switch self {
        case .Supplement1: return UIImage(named: "1") ?? UIImage()
        case .Supplement2: return UIImage(named: "2a") ?? UIImage()
        case .Supplement3: return UIImage(named: "2b") ?? UIImage()
        case .Supplement4: return UIImage(named: "3") ?? UIImage()
        case .Supplement5: return UIImage(named: "Fe") ?? UIImage()
        case .Supplement6 : return UIImage(named: "Ma") ?? UIImage()
        case .Supplement7 : return UIImage(named: "U") ?? UIImage()
        case .Supplement8 : return UIImage(named: "Zn") ?? UIImage()
        case .Supplement9 : return UIImage(named: "Cal") ?? UIImage()
        }
    }
    var kor: String {
        switch self {
        case .Supplement1:
            return "1군 발암물질"
        case .Supplement2:
            return "2A군 발암물질"
        case .Supplement3:
            return "2B군 발암물질"
        case .Supplement4:
            return "3군 발암물질"
        case .Supplement5:
            return "철분"
        case .Supplement6:
            return "마그네슘"
        case .Supplement7:
            return "유산균"
        case .Supplement8:
            return "아연"
        case .Supplement9:
            return "칼슘"
        }
    }
    var rekor: String {
        switch self {
        case .Supplement1:
            return "1군 발암물질이"
        case .Supplement2:
            return "2A군 발암물질이"
        case .Supplement3:
            return "2B군 발암물질이"
        case .Supplement4:
            return "3군 발암물질이"
        case .Supplement5:
            return "철분이"
        case .Supplement6:
            return "마그네슘이"
        case .Supplement7:
            return "유산균이"
        case .Supplement8:
            return "아연이"
        case .Supplement9:
            return "칼슘이"
        }
    }
    var eng: String {
        switch self {
        case .Supplement1:
            return "간흡충,헬리코박터 파일로리, 오피스토르키스 비베리니, 주혈흡충 혈종, 알코올, 알루미늄, 아레카 너트, 베텔 퀴드... 등"
        case .Supplement2:
            return "안드로겐(단백동화) 스테로이드, 바이오매스, 아스파탐, 질소 머스터드 등..."
        case .Supplement3:
        return "코코넛 오일, 벤조페논, 카라기난, 쿠멘, 스타이렌, 블랙탑 등..."
        case .Supplement4:
            return "염산, 하이드로 퀴논, 니트로 톨루엔, 니트 로빈, 오렌지 I, 파 툴린등..."
        case .Supplement5:
            return "Iron"
        case .Supplement6:
            return "Magnesium"
        case .Supplement7:
            return "Probiotics"
        case .Supplement8:
            return "Zinc"
        case .Supplement9:
            return "Calcium"
        }
    }
    var des: String {
        switch self {
        case .Supplement1:
        return "WHO IARC의 발암물질 분류 방식은 얼마나 확실히 암을 유발하는가에 따라서 나뉩니다. 1군의 경우는 정적발암물질로써, 사람 및 동물을 대상으로 한 연구에서 암을 일으킨다는 충분한 증거가 있는 경우입니다. 담배, 술 등이 대표적인 예입니다."
        case .Supplement2:
            return "2A군의 경우는 발암 추정(Probable)물질로써, 사람 대상의 연구에서 제한적인 증거가 나온경우와 동물 실험에서 충분한 증거가 있을 때 분류되는 등급입니다. "
        case .Supplement3:
            return "2B군의 경우는 발암 가능(Possible)물질로써, 사람 대상 연구 와 동물 실험에서 제한적인 증거가 있는 경우 분류되는 등급입니다."
        case .Supplement4:
            return "3군은 발암물질로 분류할 수 없어 인체에 암을 유발한다는 과학적 증거가 불충분한 경우입니다."
        case .Supplement5:
            return "적혈구 내의 헤모글로빈을 구성하는 중요한 성분입니다. 철분이 부족해지면 헤모글로빈의 생산과 골수에서의 적혈구 생산이 줄어듭니다. 그 결과 폐에서 산소와 결합할 헤모글로빈이 부족해지므로, 각 조직으로 산소가 충분히 공급되지 못합니다."
        case .Supplement6:
            return "마그네슘은 우리 몸에 4번째로 많은 미네랄로, 몸속 300여 개 화학반응의 조효소로 사용되는 것은 물론, 신경계에도 관여하며 근육의 이완과 수축을 도우며,몸의 에너지를 운반하는 역할을 하는 ATP와 같은 뉴클레오티드 삼인산염의 베타와 감마 인산염 사이에 결합되어 있다. 또한 유전자의 전사, 번역, 복제에 관여하는 효소들의 최적 활동을 위해서 마그네슘은 필수이고, 복제된 세포들이 새로운 단백질을 합성할 때도 필요하다"
        case .Supplement7:
            return "물질대사에 의해 탄수화물을 젖산으로 분해시키는 후벽균류 세균의 총칭이다. 요구르트, 유산균음료, 김치 등의 식품을 발효시킨다. 일부 젖산균은 창자 등의 소화기관이나 질 안에 있어, 다른 병원미생물로부터 몸을 지키고, 항상성 유지를 돕는다고 여겨진다"
        case .Supplement8:
            return " 뇌, 간, 근육 등에 존재하는 미네랄로, 인체의 성장과 발육, 면역, 생식 기능의 성숙 등의 체내 대사 반응에 관여하는 필수영양소이다. 비타민A를 운반하는 단백질인 레티놀결합단백질을 체내에서 합성하는 데 관여하기도 한다"
        case .Supplement9:
            return "골밀도 유지와 그로인한 골절 위험 감소, 골다공증 예방입니다. 칼슘은 뼈의 주요 구성 요소인 만큼, 권장섭취량을 섭취하면 뼈건강을 유지할 수 있을 것입니다. 칼슘은 그 외에도 체중감소와 지방감소 효능이 있습니다."
        }
    }

    var fontColor: UIColor {
        switch self{
        case .Supplement1:
            return UIColor(rgb: 0xFA6363)
        case .Supplement2:
            return UIColor(rgb: 0xFFB783)
        case .Supplement3:
            return UIColor(rgb: 0xEFDA67)
        case .Supplement4:
            return UIColor(rgb: 0x90CA9D)
        case .Supplement5:
            return UIColor(rgb: 0x818181)
        case .Supplement6:
            return UIColor(rgb: 0xB69894)
        case .Supplement7:
            return UIColor(rgb: 0xEFDA67)
        case .Supplement8:
            return UIColor(rgb: 0x33A3E2)
        case .Supplement9:
            return UIColor(rgb: 0xDCC7FF)
        }
    }

}
