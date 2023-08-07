//
//  LoginViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Surjeet Singh on 14/03/2019.
//  Copyright © 2019 Surjeet Singh. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    
    var headerView: HeaderViewController?
     
    
    lazy var viewModel: LoginViewModel = {
         let obj = LoginViewModel(userService: UserService())
         self.baseVwModel = obj
         return obj
     }()
    
   
    @IBOutlet weak var tableView: UITableView!
    
var placeholderText = ["Email", "Password"]
    
    //let email = String
    override func viewDidLoad() {
        
        super.viewDidLoad()

//        if autologinEnabled() {
//            self.navigateToHomeScreen()
//        }

        setupClosures()
        setupTableheader()
        setupTableFooter()
        registerCells()
     //   setUpUitext()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismisskeyboard() {
        self.view.endEditing(true)
    }
    
    
    func autologinEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "autoLoginEnabled")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView?.headingLabel.text = login.localized()
        headerView?.subheadingLabel.text = welcomeback.localized()
    }

//
//    func setUpUitext(){
//
//        headerView?.headingLabel.text = login.localized()
//        headerView?.subheadingLabel.text = welcomeback.localized()
//
//    }

    
    func setupClosures() {
        viewModel.redirectControllerClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.navigateToHomeScreen()
            }
        }
    }
    

    
    func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
        self.navigationController?.setViewControllers([tabBarController], animated: true)
        
    }
    
    func registerCells()
    {
        tableView.register(UINib(nibName:"TableViewCell" , bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }

func setupTableheader() {
    
let header = (Bundle.main.loadNibNamed("HeaderViewController", owner: self, options: nil)![0] as? UIView)
tableView.tableHeaderView = header

  
//header?.frame =  CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 300)

}
    
    
    func setupTableFooter() {
        guard let footer = Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)?.first as? FooterView else {
            
            return
        }
        
        tableView.tableFooterView = footer
        
        footer.frame =  CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 251)

        footer.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        footer.signupButton.addTarget(self, action: #selector(signupButton), for: .touchUpInside)
        footer.forgetPasswordButton.addTarget(self, action: #selector(forgetPasswordButton), for: .touchUpInside)

        footer.checkBoxButton.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        footer.checkBoxButton.setImage(UIImage(named: "checkbox-1-64 (5)"), for: .normal)
        footer.checkBoxButton.setImage(UIImage(named: "checkbox checkd"), for: .selected)
    }

    @objc func checkboxButtonTapped() {
        guard let footer = tableView.tableFooterView as? FooterView else {
            return
        }
        footer.checkBoxButton.isSelected = !footer.checkBoxButton.isSelected
    }

    
    @objc func loginButton(){
        print("button is working")
        guard let email = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? TableViewCell,
          let password = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as? TableViewCell
          else {
              return
          }
          guard let usernameCell = email.tableViewCellTextField.text,
                let passwordCell = password.tableViewCellTextField.text
          else {
              return
          }
  
        let role = "1"
        viewModel.login(withEmail: usernameCell, password: passwordCell, role:role)
        
    
       

    }
    
    @objc func forgetPasswordButton(){
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "forgotPasswordViewController") as? forgotPasswordViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
     
    @objc func signupButton(){
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInTableViewController") as? SignUpTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }

        
    }

    extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return placeholderText.count
        
    }
        
        func tableView(_ _tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        
            let cell =  tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            let accessriesView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            cell.tableViewCellTextField.placeholder = placeholderText[indexPath.row]
            cell.tableViewCellTextField.layer.cornerRadius = 15
            cell.tableViewCellTextField.layer.borderWidth = 1.0
            cell.tableViewCellTextField.clipsToBounds = true
            cell.tableViewCellTextField.rightViewMode = UITextField.ViewMode.always
            
            var image = UIImage()
            
            
            switch indexPath.row {
            case 0:
               
                
                image = UIImage(named: "Vector") ?? UIImage()
                cell.tableViewCellTextField.text = "Vasumentor1@yopmail.com"
                break
               
                
            case 1:
        
             
                
                 image = UIImage(named: "lock") ?? UIImage()
                cell.tableViewCellTextField.text = "12345678"
            
                cell.tableViewCellTextField.isSecureTextEntry = true
                break
            default:
                print("got it")
                
                
            }
            accessriesView.image = image
            rightViewContainer.addSubview(accessriesView)
            rightViewContainer.addSubview(UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10)))
            cell.tableViewCellTextField.rightView = rightViewContainer
            return cell
        }
        
    
    }


//
//extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
//
//    // ... (other code)
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//            configureCell(cell, withPlaceholder: placeholderText[indexPath.row], imageName: "Vector")
//            return cell
//
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//            configureCell(cell, withPlaceholder: placeholderText[indexPath.row], imageName: "lock")
//            cell.tableViewCellTextField.isSecureTextEntry = true
//            return cell
//
//        default:
//            print("got it")
//            return UITableViewCell()
//        }
//    }
//
//    // Helper function to configure cell
//    private func configureCell(_ cell: TableViewCell, withPlaceholder placeholder: String, imageName: String) {
//        cell.tableViewCellTextField.rightViewMode = .always
//        cell.tableViewCellTextField.placeholder = placeholder
//
//        let imageViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20)) // Adjust the container view size as per your padding requirements
//
//        let imageView = UIImageView(frame: imageViewContainer.bounds.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))) // Add padding here (5 points on all sides)
//        imageView.contentMode = .scaleAspectFit
//        let image = UIImage(named: imageName)
//        imageView.image = image
//
//        imageViewContainer.addSubview(imageView)
//        cell.tableViewCellTextField.rightView = imageViewContainer
//
//        cell.tableViewCellTextField.layer.cornerRadius = 15
//        cell.tableViewCellTextField.layer.borderWidth = 1.0
//        cell.tableViewCellTextField.clipsToBounds = true
//    }
//}
