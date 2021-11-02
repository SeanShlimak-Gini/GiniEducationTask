//
//  MainCoordinator.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 01/11/2021.
//

import UIKit

class HomeCoordinator: Coordinator
{
    //MARK: - Properties
    var childCoordinators       = [Coordinator]()
    var navigationController    : UINavigationController
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    //MARK: - Coordinator methods
    func start()
    {
        let homePresenter   = HomePresenter()
        let vc              = HomeViewController(presenter: homePresenter, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func moveToPage2()
    {
        let coordinator = DynamicCoordinator(navigationController: navigationController)
        coordinator.start()
    }
    
    func moveToPage3()
    {
        guard let homeVC        = navigationController.viewControllers[0] as? HomeViewController else { return }
        guard let numberOfCells = homeVC.page2SelectedCellIndex else { return }
        let coordinator         = ThirdPageCoordinator(navigationController: navigationController, numberOfCells: numberOfCells)
        coordinator.start()
    }
}
