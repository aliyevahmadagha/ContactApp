//
//  AddContactController.swift
//  ContactApp
//
//  Created by Khalida Aliyeva on 23.02.25.
//

import UIKit

final class AddContactController: UIViewController {
    
    var callback: ((String, String) -> Void)?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    fileprivate func configureUI() {
        nameField.placeholder = " Name"
        phoneField.placeholder = " Phone"
        saveButton.setTitle("Save", for: .normal)
        phoneField.keyboardType = .numberPad
        
    }
    
    @IBAction fileprivate func saveButton(_ sender: UIButton) {
        
        guard let name = nameField.text, let phone = phoneField.text, !name.isEmpty, !phone.isEmpty else {
            
            let alert = UIAlertController(title: "", message: "fields not be empty", preferredStyle: .alert)
            let button = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(button)
            present(alert, animated: true)
            return
        }
        callback?(name, phone)
        navigationController?.popViewController(animated: true)
    }
}
