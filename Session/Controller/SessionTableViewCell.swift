//
//  SessionTableViewCell.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 20/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit
import Kingfisher
class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var careerConsultationlabel: UILabel!
    
    @IBOutlet weak var sessionLabel: UILabel!    
    @IBOutlet weak var aliquaLabel: UILabel!
    
    @IBOutlet weak var SessionImage: UIImageView!
    
    @IBOutlet weak var economicsNatureLabel: UILabel!
    
    @IBOutlet weak var AmetminimLabel: UILabel!
    
   
    func setImage(from imageURL: URL) {
        SessionImage.kf.setImage(with: imageURL, placeholder: UIImage(named: "Group 482722"))
    }
    
}
