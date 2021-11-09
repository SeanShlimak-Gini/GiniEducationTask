//
//  FourthPageCellPresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 08/11/2021.
//

import Foundation

protocol FourthPageTableViewCellPresenterProtocol: AnyObject
{
//    var delegate: FourthPageTableViewCellPresenterDelegate? { get set }
}

//protocol FourthPageTableViewCellPresenterDelegate: AnyObject
//{
//    func didFinishFetchingSettelments(settelmentName: String)
//}

class FourthPageTableViewCellPresenter: DynamicTableViewCellPresenter, FourthPageTableViewCellPresenterProtocol
{
    //MARK: - Properties
//    var delegate: FourthPageTableViewCellPresenterDelegate?
    
    init(settelmentName: String)
    {
        super.init(titleText: settelmentName)
        self.titleLabelText = settelmentName
//        fetchSettelments(settelmentName: settelmentName)
    }
}
