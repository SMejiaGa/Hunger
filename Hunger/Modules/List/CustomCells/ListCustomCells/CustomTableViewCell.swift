//
//  CustomTableViewCell.swift
//  Hunger
//
//  Created by Sebastian Mejia on 8/10/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    private let detailBussines = DetailBussines()
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rNameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var availableButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellView.layer.cornerRadius = 8
    }
    
   // @IBAction func sendToDetails() {
    //    detailBussines.findRestaurant = ?
   // }
    
    func configCell(distance: Int, restaurantName: String, isAvailable: Bool) {
        self.distanceLabel.text = "\(distance)m"
        self.rNameLabel.text = restaurantName
        self.availableButton.isHidden = isAvailable
    }
}
