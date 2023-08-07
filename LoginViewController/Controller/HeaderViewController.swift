//
//  HeaderViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 06/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class HeaderViewController: UIView {

    @IBOutlet weak var frontImageView: UIImageView!

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subheadingLabel: UILabel!


}

//}
//    override func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)


//        if newSuperview != nil{
//            headingLabel.text = login.localized()
//            subheadingLabel.text = welcomeback.localized()
//        }
