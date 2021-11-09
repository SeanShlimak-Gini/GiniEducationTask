//
//  HomeViewController.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 26/10/2021.
//

import UIKit
import Reusable

class HomeViewController: UIViewController, Reusable
{
    //MARK: - Outlets
    @IBOutlet private weak var dataPassedButton : UIButton!
    @IBOutlet private weak var startButton      : UIButton!
    
    //MARK: - Properties
    private var presenter               : HomePresenter?
    private var numberOfTaps            = 0
    var page2SelectedCellIndex          : Int?
    private var coordinator             : HomeCoordinator?
    
    /// Custom initializer
    init(presenter: HomePresenter, coordinator: HomeCoordinator)
    {
        super.init(nibName: Self.reuseIdentifier, bundle: nil)
        self.presenter              = presenter
        self.coordinator            = coordinator
        self.presenter?.delegate    = self
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupDataPassedButton()
    }
    
    //MARK:- IBActions
    @IBAction func startButtonTapped(_ sender: UIButton)
    {
        presenter?.userTappedStartButton()
    }
    
    @IBAction func dataPassedTapped(_ sender: UIButton)
    {
        guard let startButtonText = startButton.titleLabel?.text else { return }
        if startButtonText.isInt
        {
            presenter?.userTappedDataPassedButton()
        }
    }
    
    //MARK: - Private methods
    private func setupDataPassedButton()
    {
        startButton.setTitle(StringConstants.startButtonTitle, for: .normal)
        dataPassedButton.layer.cornerRadius     = dataPassedButton.frame.size.height / 2
        dataPassedButton.layer.shadowColor      = UIColor.black.cgColor
        dataPassedButton.layer.shadowOffset     = CGSize(width: 0, height: 8)
        dataPassedButton.layer.shadowRadius     = 8
        dataPassedButton.layer.shadowOpacity    = 0.5
        dataPassedButton.layer.masksToBounds    = false
    }
    
    private func animateButtonText(text: String)
    {
        guard let buttonTitleLabel = dataPassedButton.titleLabel else { return }
        UIView.transition(with: buttonTitleLabel, duration: 2.0, options: [.curveEaseOut])
        { [weak self] in
            self?.dataPassedButton.setTitle(text, for: .normal)
            self?.view.layoutIfNeeded()
        }
    }
    
    private func addGestureRecognizerToSuperView()
    {
        let gesture                     = UITapGestureRecognizer(target: self, action: #selector(userTappedOnScreen))
        gesture.numberOfTapsRequired    = 6
        view.addGestureRecognizer(gesture)
    }
    
    private func resetViewToInitialState()
    {
        startButton.setTitle(StringConstants.startButtonTitle, for: .normal)
        view.backgroundColor        = .white
        numberOfTaps                = 0
    }
    
    @objc private func userTappedOnScreen()
    {
        self.view.backgroundColor   = .randomColor()
    }
}

extension HomeViewController: HomePresenterDelegate
{
    func navigateToPage2()
    {
        resetViewToInitialState()
        coordinator?.moveToPage2(delegate: self)
    }
    
    func navigateToPage3()
    {
        resetViewToInitialState()
        coordinator?.moveToPage3(numberOfCells: page2SelectedCellIndex ?? 0)
    }
}

extension HomeViewController: DynamicViewControllerDelegate
{
    func passCellInfo(cellLabelTitle: String)
    {
        addGestureRecognizerToSuperView()
        if cellLabelTitle.isInt
        {
            self.page2SelectedCellIndex = Int(cellLabelTitle)
            DispatchQueue.main.async
            { [weak self] in
                self?.dataPassedButton.isHidden = false
                self?.animateButtonText(text: StringConstants.dataPassedButtonTitle)
                self?.startButton.setTitle(cellLabelTitle, for: .normal)
            }
        } else
        {
            DispatchQueue.main.async
            { [weak self] in
                self?.animateButtonText(text: cellLabelTitle)
                self?.startButton.setTitle(StringConstants.startButtonTitle, for: .normal)
            }
        }
    }
}
