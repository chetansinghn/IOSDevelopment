//
//  TableViewCell.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 06/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCellTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
