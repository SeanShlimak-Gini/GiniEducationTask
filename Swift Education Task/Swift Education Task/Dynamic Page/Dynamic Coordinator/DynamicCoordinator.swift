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
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    //MARK: - Coordinator methods
    func start()
    {
        guard let homeViewController    = navigationController.viewControllers[0] as? HomeViewController else { return }
        let presenter                   = DynamicPagePresenter()
        let viewController              = DynamicPageViewController(presenter: presenter, coordinator: self)
        presenter.delegate              = viewController
        viewController.delegate         = homeViewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToPage4()
    {
        
    }
    
    func remove()
    {
        navigationController.popViewController(animated: true)
    }
}
