//
//  BaseGoogleNewsTableViewCell.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/27.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit
import HeartButton
import RealmSwift

class BaseGoogleNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heartButton: HeartButton!
    
    var googleNews: GoogleNews! {
        didSet {
            self.titleLabel?.text = googleNews.title
            self.dateLabel.text = googleNews.formattedDate()
            self.sourceLabel.text = googleNews.source
            if let guids: [String] = UserDefaults.standard.array(forKey: "guids") as? [String] {
                self.heartButton.isOn = guids.contains(googleNews!.guid)
            } else {
                self.heartButton.isOn = googleNews.isFavorite
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.heartButton.stateChanged = { sender, isOn in
        let realm = try! Realm()
            if isOn {
                try! realm.write {

                    if var guids: [String] = UserDefaults.standard.array(forKey: "guids") as? [String] {
                        guids.append(self.googleNews.guid)
                        UserDefaults.standard.set(guids, forKey: "guids")
                    } else {
                        let guids = [self.googleNews.guid]
                        UserDefaults.standard.set(guids, forKey: "guids")
                    }

                    UserDefaults.standard.synchronize()
                    self.googleNews.isFavorite = true
                    realm.add(self.googleNews, update: true)
                }
            } else {
                var guids: [String] = UserDefaults.standard.array(forKey: "guids") as! [String]
                guids = guids.filter {$0 != self.googleNews.guid}
                UserDefaults.standard.set(guids , forKey: "guids")
                UserDefaults.standard.synchronize()
                let deletingGoogleNews = realm.object(ofType: GoogleNews.self, forPrimaryKey: self.googleNews.guid)
                try! realm.write {
                    if let deletingGoogleNews = deletingGoogleNews {
                        deletingGoogleNews.isFavorite = false
                        realm.add(deletingGoogleNews, update: true)
                    }
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
