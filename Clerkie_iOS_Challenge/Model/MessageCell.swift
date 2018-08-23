//
//  MessageCell.swift
//  Clerkie_iOS_Challenge
//
//  Created by Vishwas Mukund on 8/22/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation
import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
    
   
    
    func configureCell(user: String, message: String) {
        titleLabel.text = user
        MessageLabel.text = message
    }
}
