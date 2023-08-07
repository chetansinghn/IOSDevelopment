//
//  BaseViewController.swift
//  FantomLED
//
//  Created by Surjeet Singh on 01/06/18.
//  Copyright © 2018 Surjeet Singh. All rights reserved.
//



import UIKit

class BaseViewController: UIViewController {
    
  
    var baseVwModel: BaseViewModel? {
        didSet {
            initBaseModel()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func hideNavigationBar(_ hide: Bool, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(hide, animated: animated)
    }
    
    // Cann't be override by subclass
    final func initBaseModel() {
        // Native binding
        baseVwModel?.showAlertClosure = { [weak self] (_ type:AlertType) in
            DispatchQueue.main.async {
                if type == .success, let message = self?.baseVwModel?.alertMessage  {
//                    Helper.showNotificationAlert(nil, message, type)
                    UIAlertController.showAlert(title: "", message: message)
                } else {
                    let message = self?.baseVwModel?.errorMessage ?? "Some Error occured"
//                    Helper.showNotificationAlert(nil, message , type)
                    UIAlertController.showAlert(title: "", message: message)
                }
            }
        }
        baseVwModel?.updateLoadingStatus = { [weak self] () in
                    DispatchQueue.main.async {
                        let isLoading = self?.baseVwModel?.isLoading ?? false
                        if isLoading {
                            self?.showActivityIndicator()
                        } else {
                            self?.hideActivityIndicator()
                        }
                        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
                    }
                }
            }
            
            private var activityIndicator: UIActivityIndicatorView? {
                get {
                    return objc_getAssociatedObject(self, &BaseViewController.activityIndicatorKey) as? UIActivityIndicatorView
                }
                set {
                    objc_setAssociatedObject(self, &BaseViewController.activityIndicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }

            private static var activityIndicatorKey: UInt8 = 0
            
            private func showActivityIndicator() {
                if activityIndicator == nil {
                    let indicator = UIActivityIndicatorView(style: .gray)
                    indicator.center = view.center
                    view.addSubview(indicator)
                    activityIndicator = indicator
                }
                activityIndicator?.startAnimating()
            }
            
            private func hideActivityIndicator() {
                activityIndicator?.stopAnimating()
                activityIndicator?.removeFromSuperview()
                activityIndicator = nil
            }
        }













