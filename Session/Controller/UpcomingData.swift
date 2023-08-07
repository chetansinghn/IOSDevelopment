//
//  UpcomingData.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 24/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class UpcomingData: UITableViewCell {

    @IBOutlet weak var sessionLabel: UILabel!
   
    @IBOutlet weak var upcomingDataImageView: UIImageView!
    
    @IBOutlet weak var aliquaLabel: UILabel!
    
   
    @IBOutlet weak var economicLabel: UILabel!
    
    @IBOutlet weak var careerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
