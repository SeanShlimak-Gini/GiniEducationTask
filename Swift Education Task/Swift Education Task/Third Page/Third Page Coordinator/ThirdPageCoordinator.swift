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
    
    func remove()
    {
        navigationController.popViewController(animated: true)
    }
}
