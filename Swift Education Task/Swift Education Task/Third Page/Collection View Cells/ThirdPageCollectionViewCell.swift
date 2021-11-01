//
//  ImageCollectionViewCell.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import UIKit
import Reusable

class ThirdPageCollectionViewCell: UICollectionViewCell, NibReusable
{

    @IBOutlet weak var cellImageView : UIImageView!
    private var presenter            : ThirdPageCellPresenterProtocol?
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configure(with presenter: ThirdPageCellPresenterProtocol)
    {
        self.presenter      = presenter
        presenter.delegate  = self
    }
}

extension ThirdPageCollectionViewCell: ThirdPageCellPresenterDelegate
{
    func didFinishFetchingImage(image: UIImage?)
    {
        self.cellImageView.contentMode  = .scaleAspectFill
        self.cellImageView.image        = image
    }
}
