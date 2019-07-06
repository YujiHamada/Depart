//
//  ScreenshotTableViewCell.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/07/06.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class ScreenshotTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var screenshot: Screenshot! {
        didSet {
            titleLabel.text = screenshot.title
            dateLabel.text = screenshot.date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
