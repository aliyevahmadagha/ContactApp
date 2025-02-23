//
//  UpdateController.swift
//  ContactApp
//
//  Created by Khalida Aliyeva on 23.02.25.
//

import UIKit

protocol UpdateDelegate: AnyObject {
    func update(name: String, phone: String, index: Int?)
}

final class UpdateController: UIViewController {
    
    weak var delegate: UpdateDelegate?
    
    var index: Int?
    var name: String?
    var phone: String?
    
    @IBOutlet private weak var showName: UILabel!
    @IBOutlet private weak var showPhone: UILabel!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var phoneField: UITextField!
    @IBOutlet private weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        showName.text = name
        nameField.text = name
        showPhone.text = phone
        phoneField.text = phone
    }
    
    fileprivate func configureUI() {
        updateButton.setTitle("Update", for: .normal)
        
        nameField.delegate = self
        phoneField.delegate = self
        phoneField.keyboardType = .numberPad
    }
    
    @IBAction fileprivate func updateButton(_ sender: UIButton) {
        
        guard let name = nameField.text, let phone = phoneField.text, !name.isEmpty, !phone.isEmpty else { return }
        delegate?.update(name: name, phone: phone, index: index)
        index = nil
        navigationController?.popViewController(animated: true)
    }
}

extension UpdateController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case nameField:
            showName.text = nameField.text
        default:
            showPhone.text = phoneField.text
        }
    }
}
