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
    weak var parentCoordinator  : MainCoordinator?
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    //MARK: - Coordinator methods
    func navigateToPage2(delegate: DynamicViewControllerDelegate)
    {
        let presenter           = SecondPagePresenter(coordinator: self)
        let viewController      = DynamicViewController(presenter: presenter)
        viewController.delegate = delegate
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func setPage4()
    {
        guard let homeVC        = navigationController.viewControllers.first as? HomeViewController else { return }
        let presenter           = FourthPagePresenter(coordinator: self)
        let viewController      = DynamicViewController(presenter: presenter)
        viewController.delegate = homeVC
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func remove()
    {
        parentCoordinator?.childDidFinish(self)
    }
    
    func popViewController()
    {
        navigationController.popViewController(animated: true)
    }
    
    func navigateBackToHomeVC()
    {
        navigationController.popToRootViewController(animated: true)
    }
    
}

