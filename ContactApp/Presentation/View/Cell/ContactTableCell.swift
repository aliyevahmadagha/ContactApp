//
//  ContactTableCell.swift
//  ContactApp
//
//  Created by Khalida Aliyeva on 22.02.25.
//

import UIKit

final class ContactTableCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var xibStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(model: ContactDTO) {
        nameLabel.text = model.name
        phoneLabel.text = model.phone
    }
    
}
