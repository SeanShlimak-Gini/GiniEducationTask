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
    func presentErrorForEnteredTextDialog(title: String, message: String)
    func populateTableView()
    func goButtonTapped(userText: String)
    func getNumberOfRowsInSection(section: Int) -> Int
    func getCellPresenter(for indexPath: IndexPath) -> DynamicTableViewCellPresenter?
    func setNumberOfCells(number: Int)
    func getCellTitleLabel(for indexPath: IndexPath) -> String
    func userEnteredText(userText: String)
    func resetPresenter()
}

extension DynamicPagePresenterProtocol
{
    func presentErrorForEnteredTextDialog(title: String, message: String) {}
    func populateTableView() {}
    func goButtonTapped(userText: String) {}
    func getNumberOfRowsInSection(section: Int) -> Int { return 0 }
    func getCellPresenter(for indexPath: IndexPath) -> DynamicTableViewCellPresenter? { return nil }
    func setNumberOfCells(number: Int) {}
    func getCellTitleLabel(for indexPath: IndexPath) -> String { return "" }
    func userEnteredText(userText: String) {}
    func resetPresenter() {}
}
