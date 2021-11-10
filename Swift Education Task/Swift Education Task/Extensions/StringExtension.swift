//
//  StringExtension.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 26/10/2021.
//

import Foundation
extension String
{
    var isInt: Bool
    {
        return Int(self) != nil
    }
    
    var isNotAChar: Bool
    {
        let array       = Array(self)
        var isNotChar   = false
        
        let _ = array.map
        { char in
            isNotChar = !char.isLetter
        }
        return isNotChar
    }
}
