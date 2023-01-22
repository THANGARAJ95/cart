//
//  cartTableViewCell.swift
//  cart task
//
//  Created by mac on 17/12/22.
//

import UIKit

class cartTableViewCell: UITableViewCell {

    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var vieww1: UIView!
    @IBOutlet weak var imgg: UIImageView!
    
    @IBOutlet weak var stepp: UIStepper!
    @IBOutlet weak var lbll1: UILabel!
    @IBOutlet weak var lbll2: UILabel!
     var price = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vieww1.layer.cornerRadius = 10
        vieww1.layer.borderWidth = 2
        vieww1.layer.borderColor = UIColor.blue.cgColor
        stepp.value = 1
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
