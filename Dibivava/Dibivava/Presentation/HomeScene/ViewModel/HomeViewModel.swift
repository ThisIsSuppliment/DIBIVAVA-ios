//
//  HomeViewModel.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import Foundation
import UIKit

class HomeViewModel{
    public func supplementImg(indexPath: Int)-> UIImage? {
        guard let supplement = Dibivava.supplementImg(rawValue: indexPath) else {
            return nil
        }
        return supplement.image
    }
    public func supplementKor(indexPath: Int)-> String? {
        guard let supplement = Dibivava.supplementImg(rawValue: indexPath) else {
            return nil
        }
        return supplement.kor
    }
    public func supplementEng(indexPath: Int)-> String? {
        guard let supplement = Dibivava.supplementImg(rawValue: indexPath) else {
            return nil
        }
        return supplement.eng
    }
    public func supplementColor(indexPath: Int)-> UIColor? {
        guard let supplement = Dibivava.supplementImg(rawValue: indexPath) else {
            return nil
        }
        return supplement.fontColor
    }
}
