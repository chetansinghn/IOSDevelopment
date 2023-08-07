//
//  UpcomingTableViewCell.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 25/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var upcomingImageView: UIImageView!
    
    @IBOutlet weak var sessionStartedLabel: UILabel!
    
    @IBOutlet weak var careerConsultationLabel: UILabel!
    
    @IBOutlet weak var aliquaLabel: UILabel!
    
    @IBOutlet weak var economicsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
