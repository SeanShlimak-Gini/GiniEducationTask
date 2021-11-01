//
//  DynamicPageTableViewCellPresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 27/10/2021.
//

import Foundation

protocol DynamicPageTableViewCellPresenterProtocol: AnyObject
{
    var titleLabelText: String {get}
}

class DynamicPageTableViewCellPresenter: DynamicPageTableViewCellPresenterProtocol
{
    var titleLabelText: String
    
    init(index: Int)
    {
        self.titleLabelText = String(index)
    }
}
