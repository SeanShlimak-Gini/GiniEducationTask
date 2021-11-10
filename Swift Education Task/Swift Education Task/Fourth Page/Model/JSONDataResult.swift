//
//  JSONResult.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 03/11/2021.
//

import Foundation

struct JSONDataResult: Decodable
{
    var result: ResponseObject
}

struct ResponseObject: Decodable
{
    var records: [Settelment]
}

struct Settelment: Decodable
{
    var settelmentName  : String
    
    enum CodingKeys     : String, CodingKey
    {
        case settelmentName = "שם_ישוב"
    }
}
