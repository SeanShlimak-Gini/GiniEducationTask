//
//  DynamicTableViewCell.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 07/11/2021.
//

import UIKit
import Reusable

class DynamicTableViewCell: UITableViewCell, Reusable {
    
    //MARK: - Properties
    @IBOutlet weak var dynamicCellLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with presenter: DynamicTableViewCellPresenter)
    {
        dynamicCellLabel.text = presenter.titleLabelText
    }
}
