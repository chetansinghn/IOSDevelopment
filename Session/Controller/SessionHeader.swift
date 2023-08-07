//
//  SessionHeader.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 20/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit
import FSCalendar
class SessionHeader: UIView {
        
    
    @IBOutlet weak var rightArrowButton: UIButton!
    
    
    @IBOutlet weak var leftArrowButton: UIButton!
  
   
    @IBOutlet weak var mainView: UIView!
    
    

    
   
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var selectedSegmentIndicator: UIView!
    @IBOutlet weak var todayUpcomingSegmentControl: UISegmentedControl!
    @IBOutlet weak var scheduledSessionLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var calenderButton2: UIButton!    
    @IBOutlet weak var dayweekmonthSegmentControl: UISegmentedControl!
    @IBOutlet weak var calenderView: FSCalendar!    
  
   
    @IBOutlet weak var listButton: UIButton!
    
 
    override func awakeFromNib() {
          super.awakeFromNib()
        
    //    mainViewHeightConstraints.constant = 0
        
    }
  }


     
