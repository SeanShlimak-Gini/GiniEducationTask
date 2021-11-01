//
//  HomePresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 26/10/2021.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: AnyObject
{
    func navigateToPage2()
    func navigateToPage3()
}

class HomePresenter
{
    //MARK: - Properties
    private weak var presenterDelegate: HomePresenterDelegate?
    
    init(with homeViewPresenter: HomePresenterDelegate & UIViewController)
    {
        self.presenterDelegate = homeViewPresenter
    }
    
    //MARK: - Presenter Methods
    func startButtonTapped(navigateTo: HomeNavigationDestinations)
    {
        switch navigateTo {
        case .page2:
            presenterDelegate?.navigateToPage2()
        case .page3:
            presenterDelegate?.navigateToPage3()
        case .page4:
            return
        }
    }
}
