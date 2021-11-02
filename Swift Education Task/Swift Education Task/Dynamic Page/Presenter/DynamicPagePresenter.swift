//
//  DynamicPagePresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 26/10/2021.
//

import Foundation

protocol DynamicPagePresenterDelegate: AnyObject
{
    func presentAlertDialog(title: String, message: String)
    func populateTableView()
}

class DynamicPagePresenter: NSObject
{
    //MARK: - Properties
    weak var delegate                   : DynamicPagePresenterDelegate?
    private var numberOfCells           : Int = 0
    private var cellPresenters          : [DynamicPageTableViewCellPresenter] = []
    
    //MARK: - Presenter methods
    func goButtonTapped()
    {
        makeCellPresenters()
        delegate?.populateTableView()
    }
    
    func presentAlert(title: String, message: String)
    {
        delegate?.presentAlertDialog(title: title, message: message)
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int
    {
        return self.numberOfCells
    }
    
    func getCellPresenter(for indexPath: IndexPath) -> DynamicPageTableViewCellPresenter?
    {
        guard cellPresenters.indices.contains(indexPath.row) else { return nil }
        return cellPresenters[indexPath.row]
    }
    
    func setNumberOfCells(number: Int)
    {
        self.numberOfCells = number
    }
    
    //MARK: - Private methods
    private func makeCellPresenters()
    {
        for index in 0...numberOfCells
        {
            cellPresenters.append(DynamicPageTableViewCellPresenter(index: index))
        }
    }
}
