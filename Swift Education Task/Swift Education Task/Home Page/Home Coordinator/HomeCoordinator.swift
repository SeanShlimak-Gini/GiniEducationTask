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
        let vc = HomeViewController(nibName: HomeViewController.reuseIdentifier, bundle: nil)
        navigationController.pushViewController(vc, animated: false)
    }
}
