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
    private weak var delegate   : DynamicPageViewControllerDelegate?
    
    init(navigationController: UINavigationController, delegate: DynamicPageViewControllerDelegate?)
    {
        self.navigationController = navigationController
        self.delegate             = delegate
    }
    
    //MARK: - Coordinator methods
    func start()
    {
        let vc      = DynamicPageViewController(nibName: DynamicPageViewController.reuseIdentifier, bundle: nil)
        vc.delegate = self.delegate
        navigationController.pushViewController(vc, animated: true)
    }
    
    func remove()
    {
        navigationController.popViewController(animated: true)
    }
}
