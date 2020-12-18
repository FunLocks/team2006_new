//
//  UIColor-Extension.swift
//  ChatAppWithFirerbase
//
//  Created by 佐々木翔太 on 2020/12/16.
//

import UIKit
    
extension UIColor{
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    
}
