//
//  Colors.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    class var mainred: UIColor { UIColor(named: "mainred") ?? UIColor() } //주로 쓰이는 레드

    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
            self.init(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: CGFloat(a) / 255.0
            )
        }
        convenience init(rgb: Int) {
               self.init(
                   red: (rgb >> 16) & 0xFF,
                   green: (rgb >> 8) & 0xFF,
                   blue: rgb & 0xFF
               )
           }
        
        convenience init(argb: Int) {
            self.init(
                red: (argb >> 16) & 0xFF,
                green: (argb >> 8) & 0xFF,
                blue: argb & 0xFF,
                a: (argb >> 24) & 0xFF
            )
        }
}

