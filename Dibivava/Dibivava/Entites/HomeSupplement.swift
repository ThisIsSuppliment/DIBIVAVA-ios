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
            return "감미료"
        case .Supplement2:
            return "고결방지제"
        case .Supplement3:
            return "보존료"
        case .Supplement4:
            return "산화방지제"
        case .Supplement5:
            return "안정제"
        case .Supplement6:
            return "유화제"
        case .Supplement7:
            return "증점제"
        case .Supplement8:
            return "착색료"
        case .Supplement9:
            return "향료"
        }
    }
    var rekor: String {
        switch self {
        case .Supplement1:
            return "감미료로"
        case .Supplement2:
            return "고결방지제로"
        case .Supplement3:
            return "보존료로"
        case .Supplement4:
            return "산화방지제로"
        case .Supplement5:
            return "안정제로"
        case .Supplement6:
            return "유화제로"
        case .Supplement7:
            return "증점제로"
        case .Supplement8:
            return "착색료로"
        case .Supplement9:
            return "향료로"
        }
    }
    var eng: String {
        switch self {
        case .Supplement1:
            return "스테비아, 아스파탐, 자일리톨 등"
        case .Supplement2:
            return "이산화규소, 결정셀룰로스, 규산마그네슘등"
        case .Supplement3:
        return "소브산, 안식향산, 질산나트륨 등"
        case .Supplement4:
            return "레시틴, 토코페롤, BHT 등"
        case .Supplement5:
            return "전분, 시클로덱스트린, CMC등"
        case .Supplement6:
            return "스테아린산 마그네슘, 카라기난, 카나우바왁스 등"
        case .Supplement7:
            return "구아검, 덱스트란, 히알루론산 등"
        case .Supplement8:
            return "동클로로필, 식용색소, 이산화티타늄 등"
        case .Supplement9:
            return "에틸바닐린, 유게놀, 멘톨 등"
        }
    }
    var des: String {
        switch self {
        case .Supplement1:
        return "식품 첨가물 중 감미료(Sweetener)는 음식에 당을 대체하여 달콤한 맛을 부여하는 물질입니다.감미료는 식품의 당 함량을 증가시키거나 당을 대체하여 칼로리를 감소시킬 수 있으며, 당뇨병이나 체중 관리를 위해 사용되기도 합니다.감미료는 인공 감미료와 천연 감미료로 구분됩니다.\n 1. 인공 감미료(Artificial Sweeteners):화학적으로 합성된 감미료로, 당의 달콤한 맛을 제공하지만 칼로리가 거의 없거나 매우 적습니다. 주로 저칼로리 또는 무칼로리 음료, 다이어트 제품, 과자, 더운 초콜릿, 땅콩 버터 등에 사용됩니다.\n 2. 천연 감미료(Natural Sweeteners):자연에서 추출되거나 식물 기반으로 만들어진 감미료입니다. 대부분의 천연 감미료는 칼로리가 있으며, 설탕에 비해 당도가 높을 수 있습니다. "
        case .Supplement2:
            return "식품 첨가물 중 '고결방지제(anticaking agent)'는 가루 또는 결정성 식품 제품에서 응집을 방지하고, 입자들이 서로 달라붙지 않도록 하는 역할을 합니다.고결방지제는 물기를 흡수하거나 입자 간의 마찰을 감소시키는 물질로 작용하여 제품이 거칠지 않고 자유롭게 흐를 수 있게 해줍니다.고결방지제는 거의 모든 분말 또는 결정성 식품에서 사용되며, 다음과 같은 장점을 갖고 있습니다:\n 1. 덩어리 형성 방지: 가루나 결정성 식품이 저장 또는 운반 과정에서 덩어리가 형성되는 것을 방지하여 제품의 유통기간을 연장합니다.\n 2. 향상된 유동성: 입자들이 서로 붙지 않고 자유롭게 흐를 수 있게 되므로, 제품의 유동성이 향상됩니다.\n 3. 쉬운 사용: 덩어리가 없어지므로 제품을 쉽게 측정하고 사용할 수 있습니다."
        case .Supplement3:
            return "식품 첨가물 중 보존료(Preservative)는 식품의 유통기간을 연장하고, 식품이 오랜 기간 동안 미생물의 성장과 변질을 방지하여 식품을 신선하고 안전하게 유지하는 역할을 합니다.\n보존료는 식품의 품질과 안전성을 개선하고, 부패를 방지하여 소비자들이 안전하고 맛있게 제품을 소비할 수 있도록 도와줍니다.\n식품에서 자연적으로 발생하는 미생물은 부패를 초래하는 주요 원인 중 하나입니다. 보존료는 미생물의 성장과 번식을 억제하거나 살균하여 식품의 오래된 기간 동안 안정성을 유지하는 데 사용됩니다."
        case .Supplement4:
            return "식품 첨가물 중 산화방지제(antioxidant)는 식품의 산화를 억제하여 산화에 의한 손상을 방지하는 물질을 의미합니다.\n산화는 산소와 물질 사이의 화학 반응으로 인해 발생하며, 이로 인해 산소가 자유 라디칼 형태로 변환됩니다.\n자유 라디칼은 세포 손상과 노화에 기여하는 것으로 알려져 있습니다.\n산화방지제는 이러한 자유 라디칼을 제거하거나 억제하여 세포를 보호하고 식품의 신선도와 안전성을 유지하는 역할을 합니다."
        case .Supplement5:
            return "식품 첨가물 중 안정제(Stabilizer)는 식품의 텍스처와 구조를 유지하고 안정화시키는 역할을 합니다.\n식품 제조 및 가공 과정에서 발생할 수 있는 분리, 응집, 기포화 등의 현상을 방지하거나 개선하여 제품의 안정성을 높이는 데 사용됩니다.\n안정제는 물과 기름, 또는 기타 재료 간의 상호작용을 제어하여 식품의 일관된 텍스처를 유지하고 혼합물의 안정성을 개선합니다."
        case .Supplement6:
            return "식품 첨가물 중 유화제(Emulsifier)는 서로 혼합되지 않는 두 가지 이상의 물질, 일반적으로 물과 기름, 또는 물과 기타 비효소성 물질을 안정적으로 혼합하는 역할을 합니다.\n유화제는 물과 기름의 상호작용을 조절하여 안정적인 혼합물인 에멀젼(emulsion)을 형성하도록 돕습니다. \n에멀젼은 물과 기름이 미세한 입자로 분산되어 물리적으로 안정한 상태를 유지합니다.\n에멀젼은 식품 산업에서 다양한 제품에 많이 사용됩니다. 일반적으로 에멀젼이 필요한 제품에는 맛있는 질감, 부드러움, 안정성 및 즐거운 텍스처를 제공하는데 사용됩니다. "
        case .Supplement7:
            return "식품 첨가물 중 '증점제(Thickener)'는 식품의 농도를 높여 점성을 증가시키는 역할을 합니다.\n증점제는 액체나 반응성 물질을 안정화하여 물질이 물에 떠다니거나 뭉치지 않도록 하고, 제품의 질감과 텍스처를 조절하는 데 사용됩니다.\n증점제는 물과 기름 또는 다른 두 물질의 혼합물에서 안정성과 일관성을 유지하기 위해 사용됩니다.\n이러한 혼합물은 에멀젼이라고도 하며, 증점제는 이러한 에멀젼의 안정성과 혼합물의 두께를 증가시키는 데 도움을 줍니다."
        case .Supplement8:
            return "식품 첨가물 중 '착색료(Color Additive)'는 식품에 색상을 부여하는 역할을 합니다. 착색료는 제품의 외관을 개선하고 시각적으로 더욱 매력적으로 보이도록 돕는데 사용됩니다.\n소비자들은 제품의 색상에 대해 시각적으로 구별할 수 있고, 특정한 색상을 연상시킬 수 있으며, 제품의 맛과 품질에 대한 기대를 형성하는 데에도 영향을 줍니다."
        case .Supplement9:
            return "식품 첨가물 중 '향료(Flavor)'는 식품에 특정한 맛과 향을 부여하는 물질입니다. 향료는 음식의 맛을 개선하거나 특정한 향을 더하여 제품의 맛을 향상시키는 역할을 합니다.\n 제품의 맛과 향은 소비자의 선택에 큰 영향을 미치며, 특정한 맛을 살려내기 위해 첨가물로 사용됩니다.향료는 자연에서 추출되거나 합성된 물질일 수 있으며, 일반적으로 다음과 같이 두 가지 유형으로 분류됩니다:\n1. 자연 향료(Natural Flavors): 식물, 동물, 미생물 등에서 추출된 물질을 기반으로 만들어집니다. 식품에 사용되는 자연 향료는 주로 과일, 채소, 허브, 스파이스 등으로부터 추출됩니다.\n2. 인공 향료(Artificial Flavors): 화학적으로 합성된 물질로, 자연 향료와 비슷한 맛과 향을 제공합니다. 식품 산업에서 자연 향료와 유사한 특성을 갖는 인공 향료를 개발하여 사용합니다."
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
