//
//  ProfileViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 10/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit
import DropDown
import Kingfisher

class ProfileViewController: BaseViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var base64ImageData = Data()
   
   
   
    lazy var viewModel: ProfileViewModel = {
         let obj = ProfileViewModel(userService: UserService())
         self.baseVwModel = obj
         return obj
     }()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
   
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var uploadCertificateTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var skillNameTextField: UITextField!
    @IBOutlet weak var skillTypeButton: UIButton!
    @IBOutlet weak var provincesTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addBankAccountButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    @IBOutlet weak var verificationId: UITextField!
    let datepicker = UIDatePicker()
    let dropDown = DropDown()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        
        self.dateOfBirthTextField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
        viewModel.redirectControllerClosure = { [weak self] in
            // Update the UI with profile data
            self?.getUIWithProfileData()
        }
            if let user_id = AppInstance.shared.user_Id {
                
                viewModel.getprofile(user_id: user_id)
                
        }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateProfileApi()
    }
    
   
        @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)
    }

    
    func getUIWithProfileData() {
        if let profileData = self.viewModel.getProfile?.data {
            firstNameTextField.text = profileData.firstName
            lastNameTextField.text = profileData.lastName
            emailTextField.text = profileData.email
            cityTextField.text = profileData.city
            addressTextField.text = profileData.address
            // countryTextField.text = profileData.country
            postalCodeTextField.text = profileData.postalcode
            provincesTextField.text = profileData.province
            bioTextField.text = profileData.bio
            dateOfBirthTextField.text = profileData.dateOfBirth
          //  numberCodeTextField.text = profileData.countryCode
            phoneNumberTextField.text = profileData.phone
            genderButton.setTitle(profileData.gender, for: .normal)
            languageButton.setTitle(profileData.language, for: .normal)
          
            //     imagePickerImageView.image = profileData.image
            
            if let imageURLString = profileData.image{
                let imagefull:String = Config.BASE_URL + imageURLString
                
                if let imageurl = URL(string: imagefull){
                    imageView.kf.setImage(with: imageurl,placeholder: UIImage(named: "defaultimage"))
                }else{
                    imageView.image = UIImage(named: "Group 92")
                }
            }
            
            
         }
        
        }
 
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
       updateProfileApi()
        
    }
    
    
    func updateProfileApi(){
        
        let firstName = firstNameTextField.text ?? ""
        let  lastName = lastNameTextField.text ?? ""
        let  status = "1"
        let phone = phoneNumberTextField.text ?? ""
        let country_code = countryCodeButton.currentTitle ?? ""
        let gender = genderButton.currentTitle ?? ""
        let bio = bioTextField.text ?? ""
        let city = cityTextField.text ?? ""
        let postalcode = postalCodeTextField.text ?? ""
        let address = addressTextField.text ?? ""
        let language = languageButton.currentTitle ?? ""
        let date_of_birth = dateOfBirthTextField.text ?? ""
        let province = provincesTextField.text ?? ""
     //   let image = image
        
        
        
         guard let user_id = AppInstance.shared.user_Id else {
         return
        }
      

        
        viewModel.updateProfileApi(firstName: firstName, _id:user_id  , lastName: lastName, status:status , phone: phone, image: base64ImageData, country_code: country_code, gender: gender, bio: bio, city: city, postalcode: postalcode, address: address, language: language, date_of_birth: date_of_birth, province: province)
    
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // Update the image view with the selected image
            imageView.image = selectedImage
            // Convert the selected image to a base64 string with compression quality 0.8
            if let base64String = selectedImage.jpegData(compressionQuality: 0.8) {
                self.base64ImageData = base64String
                // Now you have the Base64 encoded string of the selected image with compression quality 0.8.
            }
        }

        picker.dismiss(animated: true, completion: nil)
    }

            
            
          
       

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    @objc func dateSelected() {
            if let datePicker = self.dateOfBirthTextField.inputView as? UIDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                self.dateOfBirthTextField.text = dateFormatter.string(from:datePicker.date)
            }
            self.dateOfBirthTextField.resignFirstResponder()
        }
    
    
    @IBAction func countryCodeButtonPressed(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = story.instantiateViewController(withIdentifier: "CountryCodeViewController") as? CountryCodeViewController else {
            return
        }
        controller.delegate = self
        self.navigationController?.present(controller, animated: true)

        
    }
    
    
    @IBAction func genderButtonTapped(_ sender: UIButton) {
        
        
            dropDown.dataSource = ["Male", "Female", "Transgender"]
            dropDown.anchorView = sender
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
              guard let _ = self else { return }
              sender.setTitle(item, for: .normal)
            }
          }
        
    
    @IBAction func addDocumentsButtonPressed(_ sender: Any) {
        showDocumentPicker()
        
    }
    
    
    @IBAction func languageButtonTapped(_ sender: UIButton) {
        
        dropDown.dataSource = ["Hindi", "English", "Punjabi","kumaoni"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal)
        }
      }
        
    @IBAction func verificationButtonPressed(_ sender: Any) {
    
       showDocumentPicker()
    }
    
    
    func showDocumentPicker() {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        documentPickerController.delegate = self
        documentPickerController.modalPresentationStyle = .formSheet
        present(documentPickerController, animated: true, completion: nil)
        
    }
    
   
    
    @IBAction func skillTypeButtonTapped(_ sender: UIButton) {
        
        dropDown.dataSource = ["Singing", "Dancing", "Swimming","IOS Developer", "Data Analyst", "Java Developer"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal)
        }
      }
        
    
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
    case 0:
        
          
           firstNameTextField.text = ""
           lastNameTextField.text = ""
           languageButton.setTitle("", for: .normal)
            countryCodeButton.setTitle("", for: .normal)
           addressTextField.text = ""
           countryTextField.text = ""
           postalCodeTextField.text = ""
           skillNameTextField.text = ""
           provincesTextField.text = ""
           cityTextField.text = ""
           addBankAccountButton.setTitle("", for: .normal)
           saveButton.setTitle("", for: .normal)
           bioTextField.text = ""
           genderButton.setTitle("", for: .normal)
           dateOfBirthTextField.text = ""
           
           
        
        case 1:
        
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            languageButton.setTitle("", for: .normal)
            countryCodeButton.setTitle("", for: .normal)
            addressTextField.text = ""
            countryTextField.text = ""
            postalCodeTextField.text = ""
            skillNameTextField.text = ""
            provincesTextField.text = ""
            cityTextField.text = ""
            addBankAccountButton.setTitle("", for: .normal)
            saveButton.setTitle("", for: .normal)
            bioTextField.text = ""
            genderButton.setTitle("", for: .normal)
            dateOfBirthTextField.text = ""
         
            
        default:
            break
        }
        
    }
}

extension UITextField {
    
    func setDatePickerAsInputViewFor(target:Any, selector:Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 200.0))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        toolBar.setItems([cancel,flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}

extension ProfileViewController: UIDocumentPickerDelegate {
       func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
           if let selectedFileURL = urls.first {
               // Here, you can use the selected PDF file URL as needed.
               // For example, you can save it or display its name in a label.
               print("Selected PDF File URL: \(selectedFileURL)")
           }
       }

       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           // The user cancelled the document picker.
       }
   }


extension UIImage {
    func toBase64String(withCompressionQuality compressionQuality: CGFloat) -> String? {
        if let imageData = self.jpegData(compressionQuality: compressionQuality) {
            return imageData.base64EncodedString()
        }
        return nil
    }
}

extension ProfileViewController:CountryCodeViewControllerDelegate {
    func didSelectedCountryCode(countryCode: String) {
        var countryCodeExtension = "+\(countryCode)"
        countryCodeButton.setTitle(countryCodeExtension, for: .normal)
    }
}
