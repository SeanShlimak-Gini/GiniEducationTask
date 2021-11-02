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
    weak var delegate: HomePresenterDelegate?
    
    //MARK: - Presenter Methods
    func userTappedStartButton()
    {
        delegate?.navigateToPage2()
    }
    
    func userTappedDataPassedButton()
    {
        delegate?.navigateToPage3()
    }
    
}
