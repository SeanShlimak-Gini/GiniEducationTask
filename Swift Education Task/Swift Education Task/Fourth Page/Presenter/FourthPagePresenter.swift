//
//  FourthPagePresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 07/11/2021.
//

import UIKit

protocol FourthPagePresenterDelegate: DynamicViewControllerDelegate{}

class FourthPagePresenter: DynamicPagePresenterProtocol
{
    //MARK: - Properties
    weak var delegate                   : DynamicPagePresenterDelegate?
    var coordinator                     : DynamicCoordinator?
    private var numberOfCells           : Int = 0
    private var cellPresenters          : [FourthPageTableViewCellPresenter] = []
    
    init(coordinator: DynamicCoordinator)
    {
        self.coordinator    = coordinator
    }
    
    //MARK: - Private methods
    private func makeCellPresenters(userText: String)
    {
        if userText == "" { return }
        APIManager.makeRequest(settelmentName: userText)
        { [weak self] response in
            guard let strongSelf    = self else { return }
            if response == nil
            {
                strongSelf.notifyNoResultsForEnteredText()
            }
            
            guard let records       = response?.result.records else { return }
            if records.count == 0
            {
                strongSelf.notifyNoResultsForEnteredText()
            }
            
            let filteredNames       = strongSelf.filterSettelmentResults(settelments: records, userText: userText)
            strongSelf.setNumberOfCells(number: filteredNames.count)
            
            for index in 0..<strongSelf.numberOfCells
            {
                strongSelf.cellPresenters.append(FourthPageTableViewCellPresenter(settelmentName: filteredNames[index]))
            }
            strongSelf.delegate?.populateTableView()
        }
    }
    
    private func filterSettelmentResults(settelments: [Settelment], userText: String) -> [String]
    {
        let settelmentsNames    = settelments.map { $0.settelmentName }
        
        let filteredNames       = settelmentsNames.filter { $0.contains(userText) }
        
        return filteredNames
    }
    
    private func notifyNoResultsForEnteredText()
    {
        DispatchQueue.main.async
        { [weak self] in
            self?.delegate?
            .presentErrorForEnteredTextDialog(title: StringConstants.noResultsForTextAlertTitle, message: StringConstants.noResultsForTextAlertMessage)
        }
    }
}
extension FourthPagePresenter
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
    
    func userDidSelectRow()
    {
        coordinator?.navigateBackToHomeVC()
        coordinator?.remove()
    }
    
    func resetPresenter()
    {
        cellPresenters  = []
        numberOfCells   = 0
        delegate?.populateTableView()
    }
}
