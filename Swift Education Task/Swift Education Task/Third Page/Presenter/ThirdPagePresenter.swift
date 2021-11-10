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
    weak var coordinator        : ThirdPageCoordinator?
    
    init(numberOfCells: Int, coordinator: ThirdPageCoordinator)
    {
        self.numberOfCells  = numberOfCells
        self.coordinator    = coordinator
        makeCellPresenters()
    }
    
    //MARK: - Presenter Methods
    func userDidSelectItem()
    {
        coordinator?.moveToPage4()
        coordinator?.remove()
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int
    {
        return numberOfCells
    }
    
    func userDidLongPressInCell()
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
