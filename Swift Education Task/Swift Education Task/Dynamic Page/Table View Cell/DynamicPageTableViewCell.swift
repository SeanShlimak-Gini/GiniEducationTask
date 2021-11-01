//
//  DynamicPageTableViewCell.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 27/10/2021.
//

import UIKit
import Reusable

class DynamicPageTableViewCell: UITableViewCell, NibReusable
{
    //MARK: - Outlets
    @IBOutlet weak var cellIndexLabel       : UILabel!
    @IBOutlet private weak var nestedView   : UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        setViewAppereance()
    }
    
    func configure(with presenter: DynamicPageTableViewCellPresenter)
    {
        cellIndexLabel.text = presenter.titleLabelText
    }
    
    //MARK: - Private methods
    private func setViewAppereance()
    {
        contentView.backgroundColor     = .clear
        nestedView.layer.cornerRadius   = 8
        nestedView.backgroundColor      = .cyan
    }
}
