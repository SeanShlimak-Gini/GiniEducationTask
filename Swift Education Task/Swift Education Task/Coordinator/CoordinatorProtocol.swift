//
//  CoordinatorProtocol.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 01/11/2021.
//

import Foundation
import UIKit

protocol Coordinator
{
    var childCoordinators       : [Coordinator] { get set }
    var navigationController    : UINavigationController { get set }
    
    func start()
    func remove()
}

extension Coordinator
{
    func start(){}
    func remove(){}
}
