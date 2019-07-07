//
//  SettingTableViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/06/09.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import Firebase

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var morningSwitch: UISwitch!
    @IBOutlet weak var eveningSwitch: UISwitch!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let subscribeTopics: Array<String> = userDefaults.array(forKey: "subscribeTopics") as! Array<String>
        if !subscribeTopics.contains("morning") {
            morningSwitch.isOn = false
        }
        if !subscribeTopics.contains("evening") {
            eveningSwitch.isOn = false
        }
        
        versionLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        self.navigationItem.title = "設定"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.navigationController?.pushViewController(SelectRssTableViewController.getInstance(), animated: true)
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let vc = SimpleWebViewController(url: "https://yujihamada.github.io/depart-privacy-policy/support.html")
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = SimpleWebViewController(url: "https://yujihamada.github.io/depart-privacy-policy/privacy_policy.html")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }

    @IBAction func morningPushChanged(_ sender: UISwitch) {
        if sender.isOn {
            Messaging.messaging().subscribe(toTopic: "morning")
            let userDefaults = UserDefaults.standard
            var subscribeTopics: Array<String> = userDefaults.array(forKey: "subscribeTopics") as! Array<String>
            subscribeTopics.append("morning")
            userDefaults.set(subscribeTopics, forKey: "subscribeTopics")
            userDefaults.synchronize()
        } else {
            Messaging.messaging().unsubscribe(fromTopic: "morning")
            let userDefaults = UserDefaults.standard
            var subscribeTopics: Array<String> = userDefaults.array(forKey: "subscribeTopics") as! Array<String>
            subscribeTopics = subscribeTopics.filter {$0 != "morning"}
            userDefaults.set(subscribeTopics, forKey: "subscribeTopics")
            userDefaults.synchronize()
        }
        
    }
    @IBAction func eveningPushChanged(_ sender: UISwitch) {
        if sender.isOn {
            Messaging.messaging().subscribe(toTopic: "evening")
            let userDefaults = UserDefaults.standard
            var subscribeTopics: Array<String> = userDefaults.array(forKey: "subscribeTopics") as! Array<String>
            subscribeTopics.append("evening")
            userDefaults.set(subscribeTopics, forKey: "subscribeTopics")
            userDefaults.synchronize()
        } else {
            Messaging.messaging().unsubscribe(fromTopic: "evening")
            let userDefaults = UserDefaults.standard
            var subscribeTopics: Array<String> = userDefaults.array(forKey: "subscribeTopics") as! Array<String>
            subscribeTopics = subscribeTopics.filter {$0 != "evening"}
            userDefaults.set(subscribeTopics, forKey: "subscribeTopics")
            userDefaults.synchronize()
        }
    }
}
