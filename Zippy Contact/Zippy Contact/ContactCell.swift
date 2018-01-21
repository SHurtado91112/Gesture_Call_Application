//
//  ContactCell.swift
//  Zippy Contact
//
//  Created by Andrei Gurau on 1/20/18.
//  Copyright © 2018 Steven Hurtado. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
