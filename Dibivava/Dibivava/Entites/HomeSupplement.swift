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
