//
//  FourthPagePresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 07/11/2021.
//

import UIKit

protocol FourthPagePresenterDelegate: DynamicViewControllerDelegate{}

class FourthPagePresenter
{
    //MARK: - Properties
    weak var delegate                   : DynamicPagePresenterProtocol?
    private var numberOfCells           : Int = 0
    private var cellPresenters          : [FourthPageTableViewCellPresenter] = []
    
    //MARK: - Private methods
    private func makeCellPresenters(userText: String)
    {
        if userText == "" { return }
        APIManager.makeRequest(settelmentName: userText)
        { [weak self] response in
            guard let strongSelf    = self else { return }
            if response == nil
            {
                strongSelf.delegate?
                    .presentErrorForEnteredTextDialog(title: StringConstants.noResultsForTextAlertTitle, message: StringConstants.noResultsForTextAlertMessage)
            }
            guard let records       = response?.result.records else { return }

            let filteredResults     = strongSelf.filterSettelmentResults(settelments: records, userText: userText)
            strongSelf.setNumberOfCells(number: filteredResults.count)
            
            for index in 0...(strongSelf.numberOfCells - 1)
            {
                self?.cellPresenters.append(FourthPageTableViewCellPresenter(settelmentName: filteredResults[index]))
            }
            
            strongSelf.delegate?.populateTableView()
        }
    }
    
    private func filterSettelmentResults(settelments: [Settelment], userText: String) -> [String]
    {
        let settelmentsNames    = settelments.map
        { settelment in
            return settelment.settelmentName
        }
        
        let filteredNames       = settelmentsNames.filter
        {
            return $0.hasPrefix(userText)
        }
        
        return filteredNames
    }
}
extension FourthPagePresenter: DynamicPagePresenterProtocol
{
    //MARK: - Presenter methods
    func goButtonTapped(userText: String)
    {
        resetPresenter()
        makeCellPresenters(userText: userText)
    }
    
    func presentNoTextEnteredDialog()
    {
        delegate?.presentErrorForEnteredTextDialog(title: StringConstants.noTextAlertTitle, message: StringConstants.noTextAlertMessage)
    }
    
    func presentNoResultsForTextDialog()
    {
        delegate?.presentErrorForEnteredTextDialog(title: StringConstants.noResultsForTextAlertTitle, message: StringConstants.noResultsForTextAlertMessage)
    }
        
    func populateTableView()
    {
        delegate?.populateTableView()
    }
  
    func getNumberOfRowsInSection(section: Int) -> Int
    {
        return self.numberOfCells
    }
    
    func setNumberOfCells(number: Int)
    {
        self.numberOfCells = number
    }
    
    func getCellPresenter(for indexPath: IndexPath) -> DynamicTableViewCellPresenter?
    {
        guard cellPresenters.indices.contains(indexPath.row) else { return nil }
        return cellPresenters[indexPath.row]
    }
    
    func getCellTitleLabel(for indexPath: IndexPath) -> String
    {
        guard cellPresenters.indices.contains(indexPath.row) else { return "" }
        return cellPresenters[indexPath.row].titleLabelText
    }
    
    func userEnteredText(userText: String)
    {
        if userText == ""
        {
            presentNoTextEnteredDialog()
            resetPresenter()
            return
        }
        
        if userText.isInt
        {
            delegate?.presentErrorForEnteredTextDialog(title: StringConstants.noResultsForTextAlertTitle, message: StringConstants.noResultsForTextAlertMessage)
            resetPresenter()
            return
        }
    }
    
    func resetPresenter()
    {
        cellPresenters  = []
        numberOfCells   = 0
        delegate?.populateTableView()
    }
}