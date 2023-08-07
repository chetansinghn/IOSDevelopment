//
//  DashboardtableViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 14/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit
import SwiftUI
class DashboardViewController: BaseViewController {
    
    lazy var viewModel: DashboardViewModel = {
        let obj = DashboardViewModel(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTableheader()
        
        
        viewModel.updateMentorApi(user_id:"63db99404a465b1ee8250423")
        
        
    }
  
    func setupTableheader() {
        
        let header = (Bundle.main.loadNibNamed("DashboardHeader", owner: self, options: nil)![0] as? UIView)
        tableView?.tableHeaderView = header
//        if let tableViewWidth = tableView?.frame.size.width {
//            let headerFrame = CGRect(x: 0, y: 0, width: Int(tableViewWidth), height: 500)
//            header?.frame = headerFrame
//        }
        
    }
}


extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        DashboardTableViewCell
        return cell
        
    }
    
}
