//
//  DynamicPageTableViewCellPresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 27/10/2021.
//

import Foundation

class SecondPageTableViewCellPresenter: DynamicTableViewCellPresenter
{
    init(index: Int)
    {
        super.init(titleText: String(index))
    }
}
