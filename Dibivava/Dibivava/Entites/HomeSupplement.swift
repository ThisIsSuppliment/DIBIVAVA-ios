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
        case .Supplement1: return UIImage(named: "A") ?? UIImage()
        case .Supplement2: return UIImage(named: "B") ?? UIImage()
        case .Supplement3: return UIImage(named: "C") ?? UIImage()
        case .Supplement4: return UIImage(named: "D") ?? UIImage()
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
            return "비타민 A"
        case .Supplement2:
            return "비타민 B"
        case .Supplement3:
            return "비타민 C"
        case .Supplement4:
            return "비타민 D"
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
            return "비타민 A가"
        case .Supplement2:
            return "비타민 B가"
        case .Supplement3:
            return "비타민 C가"
        case .Supplement4:
            return "비타민 D가"
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
            return "Vitamin A"
        case .Supplement2:
            return "Vitamin B"
        case .Supplement3:
            return "Vitamin C"
        case .Supplement4:
            return "Vitamin D"
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
        return "지용성 비타민으로서 생물의 성장과 발달, 생식, 상피세포의 분화, 세포 분열, 유전자 조절 및 면역 반응 등에 다양하게 활용되는 레티노이드(retinoid) 화합물의 집합이다. 레티노이드는 '망막'을 의미하는 '레티나(retina)'에서 유래한 이름인데 전통적으로 비타민A의 섭취가 눈에 도움을 준다는 효능에 따른 것이다. 실제로 비타민A는 안구의 시야 인식 기작에 관여하며 결핍 시 안구건조증과 야맹증, 실명의 원인이 된다."
        case .Supplement2:
            return "비타민B 복합체(Vitamin B-complex) 또는 비타민B 군(群)은 비타민C(아스코르브산)를 제외한 수용성 비타민(극성 비타민)을 분류하는 집합이다. 비타민B에 속하는 비타민들은 주로 체내에서 세포의 물질 대사를 돕는 조효소의 역할을 한다. "
        case .Supplement3:
            return " 수용성 비타민의 하나로 콜라겐 합성 및 세포 내 에너지 대사의 조효소로 사용되며, 항산화 작용을 하는 강력한 환원제이다. 거의 모든 동물 및 식물군에 포함되어 있으나 포유동물 중 인간이나 침팬지 등의 유인원 계열은 이를 체내에서 합성할 수 없어 외부로부터 섭취해야 한다."
        case .Supplement4:
            return "지용성 비타민의 한 종류. 칼슘 대사를 조절하여 체내 칼슘 농도의 항상성과 뼈의 건강을 유지하는 데 관여하고 세포의 증식 및 분화의 조절, 면역기능 등에 관여하는 것으로 알려져 있다. 부족 시 구루병, 골연화증, 골다공증의 위험이 높아지는 것으로 알려져 있다."
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
            return UIColor(rgb: 0xDCACCE)
        case .Supplement2:
            return UIColor(rgb: 0xF1B78E)
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
