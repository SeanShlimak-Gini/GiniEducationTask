//
//  DynamicViewController.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 07/11/2021.
//

import UIKit
import Reusable

protocol DynamicViewControllerDelegate: AnyObject
{
    func passCellInfo(cellLabelTitle: String)
}

class DynamicViewController: UIViewController, NibReusable {
    //MARK: - Outlets
    @IBOutlet private weak var userTextField    : UITextField!
    @IBOutlet private weak var goButton         : UIButton!
    @IBOutlet private weak var tableView        : UITableView!
    
    //MARK: - Properties
    weak var delegate           : DynamicViewControllerDelegate?
    private var coordinator     : DynamicCoordinator?
    private var presenter       : DynamicPagePresenterProtocol?
    
    /// Custom initializer
    init(coordinator: DynamicCoordinator, presenter: DynamicPagePresenterProtocol)
    {
        super.init(nibName: nil, bundle: nil)
        self.presenter      = presenter
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addTextFieldDelegate()
        setupTableView()
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton)
    {
        guard let userText = userTextField.text else { return }
        presenter?.userEnteredText(userText: userText)
        presenter?.goButtonTapped(userText: userText)
    }
    
    //MARK: - Private methods
    private func setupTableView()
    {
        registerTableViewCell()
        tableView.dataSource    = self
        tableView.delegate      = self
    }
    
    private func addTextFieldDelegate()
    {
        userTextField.delegate = self
    }
    
    private func registerTableViewCell()
    {
        tableView.register(UINib(nibName: DynamicTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DynamicTableViewCell.reuseIdentifier)
    }
    
    private func setViewsBackgroundColor(isErrorState: Bool)
    {
        presenter?.setNumberOfCells(number: 0)
        if isErrorState
        {
            DispatchQueue.main.async
            { [weak self] in
                self?.view.backgroundColor      = .red
                self?.tableView.backgroundColor = .red
                self?.tableView.reloadData()
            }
        } else
        {
            DispatchQueue.main.async
            { [weak self] in
                self?.view.backgroundColor      = .white
                self?.tableView.backgroundColor = .white
                self?.tableView.reloadData()
            }
        }
    }
    
    private func createErrorForEnteredTextDialog(title: String, message: String) -> UIAlertController
    {
        let alertDialog = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "OK",
                                    style: .default,
                                       handler: { _ in
            alertDialog.dismiss(animated: true)
        }))
        return alertDialog
    }
}

extension DynamicViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let presenter = presenter else { return 0 }
        return presenter.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let presenter = presenter?.getCellPresenter(for: indexPath) else { return UITableViewCell() }
        let cell            : DynamicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: presenter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let cellTitle = presenter?.getCellTitleLabel(for: indexPath) else { return }
        delegate?.passCellInfo(cellLabelTitle: cellTitle)
        cellTitle.isInt ?  coordinator?.popViewController() : coordinator?.navigateBackToHomeVC()
        coordinator?.remove()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DynamicViewController: DynamicPagePresenterProtocol
{
    func populateTableView()
    {
        DispatchQueue.main.async
        { [weak self] in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
    }
    
    func presentErrorForEnteredTextDialog(title: String, message: String)
    {
        setViewsBackgroundColor(isErrorState: true)
        present(createErrorForEnteredTextDialog(title: title, message: message), animated: true)
        { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
            {
                self?.setViewsBackgroundColor(isErrorState: false)
            }
        }
    }
}

extension DynamicViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField.text == ""
        {
            presenter?.setNumberOfCells(number: 0)
            DispatchQueue.main.async
            { [weak self] in
                self?.presenter?.resetPresenter()
                self?.tableView.reloadData()
            }
        }
    }
}
