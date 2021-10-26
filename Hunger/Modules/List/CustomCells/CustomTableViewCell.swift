//
//  CustomTableViewCell.swift
//  Hunger
//
//  Created by Sebastian Mejia on 8/10/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellView.layer.cornerRadius = 8
    }
    
    func configCell(user: String, message: String){
        self.nameLabel.text = user
        self.messageLabel.text = message
    }
    
}
