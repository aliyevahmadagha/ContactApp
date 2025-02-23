//
//  ContactController.swift
//  ContactApp
//
//  Created by Khalida Aliyeva on 22.02.25.
//

import UIKit

final class ContactController: UIViewController {
    
    private var myContacts: [ContactDTO] = [.init(name: "person1", phone: "1111")]
    
    @IBOutlet private weak var contactTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUI()
    }
    
    fileprivate func configureUI() {
        contactTable.rowHeight = 48
    }
    
    fileprivate func configureTableView() {
        contactTable.delegate = self
        contactTable.dataSource = self
        contactTable.register(UINib(nibName: "ContactTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ContactTableCell")
    }
    
    @IBAction fileprivate func addButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddContactController") as! AddContactController
        navigationController?.pushViewController(controller, animated: true)
        
        controller.callback = { [weak self] name, phone in
            guard let self = self else { return }
            
            let newContact = ContactDTO(name: name, phone: phone)
            myContacts.append(newContact)
            contactTable.reloadData()
        }
    }
}

extension ContactController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableCell", for: indexPath) as! ContactTableCell
        let model = myContacts[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { _, _, _ in
            self.myContacts.remove(at: indexPath.row)
            self.contactTable.reloadData()
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "") { _, _, _ in
            let storybard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = storybard.instantiateViewController(withIdentifier: "UpdateController") as! UpdateController
            self.navigationController?.pushViewController(controller, animated: true)
            let model = self.myContacts[indexPath.row]
            controller.name = model.name
            controller.phone = model.phone
            controller.index = indexPath.row
            controller.delegate = self
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        updateAction.image = UIImage(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ContactController: UpdateDelegate {
    
    func update(name: String, phone: String, index: Int?) {
        self.myContacts[index ?? 0] = ContactDTO(name: name, phone: phone)
        self.contactTable.reloadData()
    }
}
