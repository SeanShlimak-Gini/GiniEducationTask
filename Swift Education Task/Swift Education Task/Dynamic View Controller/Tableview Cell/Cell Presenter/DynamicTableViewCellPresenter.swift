//
//  DynamicTableViewCellPresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 07/11/2021.
//

import Foundation

protocol DynamicTableViewCellPresenterProtocol: AnyObject
{
    var titleLabelText: String {get}
}

class DynamicTableViewCellPresenter: DynamicTableViewCellPresenterProtocol
{
    var titleLabelText: String
    
    init(titleText: String)
    {
        self.titleLabelText = titleText
    }
}
