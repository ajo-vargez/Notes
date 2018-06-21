//
//  NotesCell.swift
//  Notes
//
//  Created by Ajo M Varghese on 30/05/18.
//  Copyright © 2018 Ajo M Varghese. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setLabels(note: Notes)  {
        self.titleLabel.text = note.titleText
        self.descriptionLabel.text = note.descriptionText
        //self.timeLabel. = note.timeStamp
    }
    
}
