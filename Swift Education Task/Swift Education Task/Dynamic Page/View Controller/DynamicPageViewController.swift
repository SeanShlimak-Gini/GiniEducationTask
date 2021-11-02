//
//  DynamicPageViewController.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 26/10/2021.
//

import UIKit
import Reusable

protocol DynamicPageViewControllerDelegate: AnyObject
{
    func passSelectedCellIndex(index: Int)
}

class DynamicPageViewController: UIViewController, Reusable
{
    //MARK: - Outlets
    @IBOutlet private weak var userTextField    : UITextField!
    @IBOutlet private weak var goButton         : UIButton!
    @IBOutlet weak var tableView                : UITableView!
    
    //MARK: - Properties
    private var presenter                       : DynamicPagePresenter?
    weak var delegate                           : DynamicPageViewControllerDelegate?
    private var coordinator                     : DynamicCoordinator?
    
    /// Custom initializer
    init(presenter: DynamicPagePresenter, coordinator: DynamicCoordinator)
    {
        super.init(nibName: Self.reuseIdentifier, bundle: nil)
        self.presenter      = presenter
        self.coordinator    = coordinator
        
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource    = self
        tableView.delegate      = self
        registerTableViewCell()
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton)
    {
        let userText        : String? = checkIsUserTextFieldValid() ? userTextField.text : nil
        guard let number    = Int(userText ?? "0") else { return }
        presenter?.setNumberOfCells(number: number)
        presenter?.goButtonTapped()
    }
    
    //MARK: - Private methods
    private func registerTableViewCell()
    {
        tableView.register(cellType: DynamicPageTableViewCell.self)
    }
    
    private func checkIsUserTextFieldValid() -> Bool
    {
        if userTextField.text == "" || userTextField.text == nil
        {
            presenter?.presentAlert(title: StringConstants.noTextAlertTitle, message: StringConstants.noTextAlertMessage)
            return false
        }
        guard let userText = userTextField.text else { return false }
        if !userText.isInt
        {
            presenter?.presentAlert(title: StringConstants.notANumberAlertTitle, message: StringConstants.notANumberAlertMessage)
            return false
        }
        return true
    }
    
    private func setViewsBackgroundColor(isErrorState: Bool)
    {
        if isErrorState
        {
            DispatchQueue.main.async
            { [weak self] in
                self?.view.backgroundColor      = .red
                self?.tableView.backgroundColor = .red
            }
        } else
        {
            DispatchQueue.main.async
            { [weak self] in
                self?.view.backgroundColor      = .white
                self?.tableView.backgroundColor = .white
            }
        }
    }
}

extension DynamicPageViewController: DynamicPagePresenterDelegate
{
    func populateTableView()
    {
        DispatchQueue.main.async
        { [weak self] in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
    }
    
    func presentAlertDialog(title: String, message: String) {
        setViewsBackgroundColor(isErrorState: true)
        let dialog  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action  = UIAlertAction(title: "OK", style: .default)
        { [weak self] _ in
            self?.dismiss(animated: true)
            self?.setViewsBackgroundColor(isErrorState: false)
        }
        dialog.addAction(action)
        present(dialog, animated: true)
    }
}

//MARK: - Tableview handling (Datasource + Delegate)
extension DynamicPageViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let numberOfRows = presenter?.getNumberOfRowsInSection(section: section) else { return 0 }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell            = tableView.dequeueReusableCell(for: indexPath) as DynamicPageTableViewCell
        guard let presenter = presenter?.getCellPresenter(for: indexPath) else { return UITableViewCell() }
        cell.configure(with: presenter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        delegate?.passSelectedCellIndex(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.remove()
    }
}
