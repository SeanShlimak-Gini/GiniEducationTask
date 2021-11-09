//
//  DynamicCoordinator.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 01/11/2021.
//

import UIKit
class DynamicCoordinator: Coordinator
{
    //MARK: - Properties
    var childCoordinators       : [Coordinator] = []
    var navigationController    : UINavigationController
    private weak var delegate   : DynamicViewControllerDelegate?
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    //MARK: - Coordinator methods
    func navigateToPage2(delegate: DynamicViewControllerDelegate)
    {
        let presenter           = SecondPagePresenter()
        let viewController      = DynamicViewController(coordinator: self, presenter: presenter)
        viewController.delegate = delegate
        presenter.delegate      = viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func setPage4()
    {
        guard let homeVC        = navigationController.viewControllers.first as? HomeViewController else { return }
        let presenter           = FourthPagePresenter()
        let viewController      = DynamicViewController(coordinator: self, presenter: presenter)
        viewController.delegate = homeVC
        presenter.delegate      = viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func remove()
    {
        navigationController.popViewController(animated: true)
    }
    
    func navigateBackToHomeVC()
    {
        navigationController.popToRootViewController(animated: true)
    }
    
}

