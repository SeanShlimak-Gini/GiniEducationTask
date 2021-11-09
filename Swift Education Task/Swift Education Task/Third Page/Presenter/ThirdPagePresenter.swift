//
//  ThirdPagePresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import Foundation

protocol ThirdPagePresenterProtocol: AnyObject {}

class ThirdPagePresenter: ThirdPagePresenterProtocol
{
    //MARK: - Properties
    weak var delegate           : ThirdPagePresenterProtocol?
    private var cellPresenters  : [ThirdPageCellPresenterProtocol] = []
    private var numberOfCells   = 0
    
    init(numberOfCells: Int)
    {
        self.numberOfCells  = numberOfCells
        makeCellPresenters()
    }
    
    //MARK: - Presenter Methods
    
    func getNumberOfRowsInSection(section: Int) -> Int
    {
        return numberOfCells
    }
    
    func removeOneCellFromTotalCount()
    {
        if numberOfCells == 0
        {
            return
        } else
        {
            numberOfCells -= 1
        }
    }
    
    func getCellPresenter(for indexPath: IndexPath) -> ThirdPageCellPresenterProtocol?
    {
        guard cellPresenters.indices.contains(indexPath.row) else { return nil }
        return cellPresenters[indexPath.row]
    }
    
    func makeCellPresenters()
    {
        for _ in 0...numberOfCells
        {
            cellPresenters.append(ThirdPageCellPresenter())
        }
    }
}
