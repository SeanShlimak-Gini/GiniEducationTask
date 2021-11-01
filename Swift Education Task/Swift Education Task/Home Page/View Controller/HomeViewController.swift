//
//  HomeViewController.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 26/10/2021.
//

import UIKit

enum HomeNavigationDestinations
{
    case page2
    case page3
    case page4
}

class HomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var dataPassedButton : UIButton!
    @IBOutlet private weak var startButton      : UIButton!
    
    //MARK: - Properties
    private lazy var presenter          = HomePresenter(with: self)
    private var numberOfTaps            = 0
    private var page2SelectedCellIndex  = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupDataPassedButton()
    }
    
    //MARK:- IBActions
    @IBAction func startButtonTapped(_ sender: UIButton)
    {
        presenter.startButtonTapped(navigateTo: .page2)
    }
    
    @IBAction func dataPassedTapped(_ sender: UIButton)
    {
        guard let startButtonText = startButton.titleLabel?.text else { return }
        if startButtonText.isInt
        {
            presenter.startButtonTapped(navigateTo: .page3)
        }
    }
    
    //MARK: - Private methods
    private func setupDataPassedButton()
    {
        startButton.setTitle("Start!", for: .normal)
        dataPassedButton.layer.cornerRadius     = dataPassedButton.frame.size.height / 2
        dataPassedButton.layer.shadowColor      = UIColor.black.cgColor
        dataPassedButton.layer.shadowOffset     = CGSize(width: 0, height: 8)
        dataPassedButton.layer.shadowRadius     = 8
        dataPassedButton.layer.shadowOpacity    = 0.5
        dataPassedButton.layer.masksToBounds    = false
    }
    
    
    private func animateButtonText(text: String)
    {
        guard let buttonTitleLabel  = dataPassedButton.titleLabel else { return }
        UIView.transition(with: buttonTitleLabel, duration: 5.0, options: [.curveEaseOut])
        { [weak self] in
            self?.dataPassedButton.setTitle(text, for: .normal)
        }
    }
    
    private func addGestureRecognizerToSuperView()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userTappedOnScreen))
        super.view.addGestureRecognizer(gesture)
    }
    
    private func resetViewToInitialState()
    {
        view.backgroundColor        = .white
        numberOfTaps                = 0
    }
    
    private func getNavigationController() -> UINavigationController?
    {
        guard let navigationController = navigationController else { return nil }
        return navigationController
    }
    
    @objc private func userTappedOnScreen()
    {
        if numberOfTaps == 5
        {
            self.view.backgroundColor   = .randomColor()
            numberOfTaps                = 0
        } else
        {
            numberOfTaps += 1
        }
    }
}

extension HomeViewController: HomePresenterDelegate
{
    
    func navigateToPage2()
    {
        resetViewToInitialState()
        guard let navController     = getNavigationController() else { return }
        let viewController          = DynamicPageViewController(nibName: "DynamicPageViewController", bundle: nil)
        viewController.delegate     = self
        navController.pushViewController(viewController, animated: true)
    }
    
    func navigateToPage3()
    {
        resetViewToInitialState()
        guard let navController     = getNavigationController() else { return }
        let viewController          = ThirdPageCollectionViewController(nibName: "ThirdPageCollectionViewController", bundle: nil)
        viewController.setNumberOfCells(number: page2SelectedCellIndex)
        navController.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: DynamicPageViewControllerDelegate
{
    func passSelectedCellIndex(index: Int)
    {
        self.page2SelectedCellIndex = index
        addGestureRecognizerToSuperView()
        DispatchQueue.main.async
        { [weak self] in
            self?.dataPassedButton.isHidden = false
            self?.animateButtonText(text: "Data Passed!")
            self?.startButton.setTitle(String(index), for: .normal)
        }
    }
}
