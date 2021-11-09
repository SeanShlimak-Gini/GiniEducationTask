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
    private var vc              : UIViewController!
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    //MARK: - Coordinator methods
    func start()
    {
        let homePresenter   = HomePresenter()
        vc                  = HomeViewController(presenter: homePresenter, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func moveToPage2(delegate: DynamicViewControllerDelegate)
    {
        let coordinator = DynamicCoordinator(navigationController: navigationController)
        coordinator.navigateToPage2(delegate: delegate)
    }
    
    func moveToPage3(numberOfCells: Int)
    {
        let coordinator = ThirdPageCoordinator(navigationController: navigationController, numberOfCells: numberOfCells)
        coordinator.start()
    }
}
