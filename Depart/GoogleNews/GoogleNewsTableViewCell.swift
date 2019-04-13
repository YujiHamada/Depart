//
//  TestTableViewCell.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/27.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit

class GoogleNewsTableViewCell: BaseGoogleNewsTableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    
    override var googleNews: GoogleNews! {
        didSet {
            if !googleNews.image_url.isEmpty {
                self.newsImage.image = nil
                self.newsImage.af_cancelImageRequest();
                self.newsImage?.af_setImage(withURL: URL(string: googleNews.image_url)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
