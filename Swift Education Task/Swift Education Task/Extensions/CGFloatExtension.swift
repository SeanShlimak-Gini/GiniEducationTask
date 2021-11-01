//
//  CGColorExtension.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import UIKit

extension CGFloat
{
    static func randomCGFloat() -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(Int32.max)
    }
}
