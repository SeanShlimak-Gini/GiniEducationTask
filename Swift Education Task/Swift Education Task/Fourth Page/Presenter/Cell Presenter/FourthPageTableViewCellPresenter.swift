//
//  FourthPageCellPresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 08/11/2021.
//

import Foundation

protocol FourthPageTableViewCellPresenterProtocol: AnyObject {}

class FourthPageTableViewCellPresenter: DynamicTableViewCellPresenter, FourthPageTableViewCellPresenterProtocol
{
    init(settelmentName: String)
    {
        super.init(titleText: settelmentName)
    }
}
