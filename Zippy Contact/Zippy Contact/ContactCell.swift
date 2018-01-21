//
//  ContactCell.swift
//  Zippy Contact
//
//  Created by Andrei Gurau on 1/20/18.
//  Copyright © 2018 Steven Hurtado. All rights reserved.
//

import UIKit

class UILabel2 : UILabel {
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
}

extension UILabel2 {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

class ContactCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel2!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        textView.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);
//        nameLabel.inset
        nameLabel.layer.cornerRadius = 4
        nameLabel.clipsToBounds = true
        
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowRadius = 10
        nameLabel.layer.shadowOpacity = 0.48
        nameLabel.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
