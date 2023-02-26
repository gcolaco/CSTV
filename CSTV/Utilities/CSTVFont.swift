//
//  CSTVFont.swift
//  CSTV
//
//  Created by Gustavo Colaço on 26/02/23.
//

import UIKit

enum CSTVFont {
    static func robotoRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Regular", size: size)
    }
    
    static func robotoMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Medium", size: size)
    }
    
    static func robotoBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Bold", size: size)
    }
}
