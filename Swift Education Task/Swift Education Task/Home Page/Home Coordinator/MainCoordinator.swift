//
//  MainCoordinator.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 01/11/2021.
//

import UIKit

class MainCoordinator: Coordinator
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
        let child               = DynamicCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.navigateToPage2(delegate: delegate)
    }
    
    func moveToPage3(numberOfCells: Int)
    {
        let child               = ThirdPageCoordinator(navigationController: navigationController, numberOfCells: numberOfCells)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?)
    {
        for (index, coordinator) in childCoordinators.enumerated()
        {
            if coordinator === child
            {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
