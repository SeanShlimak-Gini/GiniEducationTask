//
//  ThirdPageCoordinator.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 01/11/2021.
//

import UIKit

class ThirdPageCoordinator: Coordinator
{
    //MARK: - Properties
    var childCoordinators       : [Coordinator] = []
    var navigationController    : UINavigationController
    private var numberOfCells   = 0
    weak var parentCoordinator  : MainCoordinator?
    
    init(navigationController: UINavigationController, numberOfCells: Int)
    {
        self.navigationController   = navigationController
        self.numberOfCells          = numberOfCells
    }
    
    //MARK: - Coordinator methods
    func start()
    {
        let presenter   = ThirdPagePresenter(numberOfCells: numberOfCells)
        let vc          = ThirdPageCollectionViewController(presenter: presenter, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func moveToPage4()
    {
        let child                   = DynamicCoordinator(navigationController: navigationController)
        guard let parentCoordinator = parentCoordinator else { return }
        child.parentCoordinator     = parentCoordinator
        child.setPage4()
    }
    
    func remove()
    {
        parentCoordinator?.childDidFinish(self)
    }
    
    func popViewController()
    {
        navigationController.popViewController(animated: true)
    }
}
