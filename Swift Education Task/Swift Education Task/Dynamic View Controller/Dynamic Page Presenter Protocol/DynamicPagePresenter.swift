//
//  DynamicPagePresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 04/11/2021.
//

import Foundation
import UIKit


protocol DynamicPagePresenterProtocol: AnyObject
{
    var delegate      : DynamicPagePresenterDelegate? { get set }
    
    func goButtonTapped(userText: String)
    func getNumberOfRowsInSection(section: Int) -> Int
    func getCellPresenter(for indexPath: IndexPath) -> DynamicTableViewCellPresenter?
    func setNumberOfCells(number: Int)
    func getCellTitleLabel(for indexPath: IndexPath) -> String
    func userEnteredText(userText: String)
    func userDidSelectRow()
    func resetPresenter()
}

extension DynamicPagePresenterProtocol
{
    func resetPresenter() {}
}

protocol DynamicPagePresenterDelegate: AnyObject
{
    func populateTableView()
    func presentErrorForEnteredTextDialog(title: String, message: String)
}
