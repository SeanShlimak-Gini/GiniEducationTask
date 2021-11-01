//
//  ThirdPageCellPresenter.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import Foundation
import UIKit
import EzImageLoader
import EzHTTP

protocol ThirdPageCellPresenterProtocol: AnyObject
{
    var delegate: ThirdPageCellPresenterDelegate? { get set }
}

protocol ThirdPageCellPresenterDelegate: AnyObject
{
    func didFinishFetchingImage(image: UIImage?)
}

class ThirdPageCellPresenter: ThirdPageCellPresenterProtocol
{
    weak var delegate   : ThirdPageCellPresenterDelegate?
    private var url     : String
    {
        "https://picsum.photos/\(getRandomSize())"
    }
    
    init()
    {
        fetchImage()
    }
    
    //MARK: - Private methods
    private func fetchImage()
    {
        PicsumManager.getImage(url: url)
        { [weak self] image in
            self?.delegate?.didFinishFetchingImage(image: image)
        }
    }
    
    private func getRandomSize() -> Int
    {
        return Int.random(in: 200...300)
    }
}
