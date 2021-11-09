//
//  UIColorExtension.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import UIKit

extension UIColor
{
    static func randomColor() -> UIColor
    {
        return UIColor(
            red     : .randomCGFloat(),
            green   : .randomCGFloat(),
            blue    : .randomCGFloat(),
            alpha: 1.0
        )
    }
}
