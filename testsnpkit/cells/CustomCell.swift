//
//  CustomCell.swift
//  testsnpkit
//
//  Created by Saeed Dehshiri on 8/25/19.
//  Copyright © 2019 Saeed Dehshiri. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    static let Identifier = "customCell"
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(text: String) {
        label.text = text
    }
    
}
