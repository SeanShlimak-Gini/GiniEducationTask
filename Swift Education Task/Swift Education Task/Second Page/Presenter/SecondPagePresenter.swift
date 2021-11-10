//
//  DynamicPagePresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 26/10/2021.
//
import Foundation

protocol SecondPagePresenterDelegate: DynamicViewControllerDelegate{}

class SecondPagePresenter
{
    //MARK: - Properties
    weak var delegate                   : DynamicPagePresenterProtocol?
    private var numberOfCells           : Int = 0
    private var cellPresenters          : [SecondPageTableViewCellPresenter] = []
    
    //MARK: - Private methods
    private func makeCellPresenters()
    {
        for index in 0...numberOfCells
        {
            self.cellPresenters.append(SecondPageTableViewCellPresenter(index: index))
        }
    }
}

extension SecondPagePresenter: DynamicPagePresenterProtocol
{
    //MARK: - Presenter methods
    func goButtonTapped(userText: String)
    {
        if userText == ""
        {
            presentNoTextEnteredDialog()
            return
        }
        
        makeCellPresenters()
        populateTableView()
    }
    
    func presentNoTextEnteredDialog()
    {
        delegate?.presentErrorForEnteredTextDialog(title: StringConstants.noTextAlertTitle, message: StringConstants.noTextAlertMessage)
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
        if userText.isEmpty
        {
            presentNoTextEnteredDialog()
            return
        }
        
        if !userText.isInt
        {
            delegate?.presentErrorForEnteredTextDialog(title: StringConstants.notANumberAlertTitle, message: StringConstants.notANumberAlertMessage)
            return
        }
        setNumberOfCells(number: Int(userText)!)
    }
}
