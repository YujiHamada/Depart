//
//  SelectRssTableViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/06/08.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class SelectRssTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var googleNewsSwitch: UISwitch!
    @IBOutlet weak var scSwitch: UISwitch!
    @IBOutlet weak var apparelSwitch: UISwitch!
    @IBOutlet weak var eventcheckerSwitch: UISwitch!
    @IBOutlet weak var foodSwitch: UISwitch!
    @IBOutlet weak var ryutsuSwitch: UISwitch!
    @IBOutlet weak var cosmeticSwitch: UISwitch!
    @IBOutlet weak var interiorSwitch: UISwitch!
    
    @IBOutlet weak var submitButton: UIButton!
    static let SUBSCRIBE_RSS = "subscribeRss"
    
    static func getInstance() -> SelectRssTableViewController {
        let storyboard = UIStoryboard(name: "SelectRss", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SelectRssTableViewController") as! SelectRssTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwitch()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "決定", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    private func setSwitch(){
        let userDefaults = UserDefaults.standard
        let subscribeRss: [Int]? = userDefaults.array(forKey: SelectRssTableViewController.SUBSCRIBE_RSS) as? [Int]
        if let subscribeRss = subscribeRss {
            
            submitButton.removeFromSuperview()
            
            if !subscribeRss.contains(Rss.depart.rawValue) {
                googleNewsSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.sc.rawValue) {
                scSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.apparel.rawValue) {
                apparelSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.eventchecker.rawValue) {
                eventcheckerSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.food.rawValue) {
                foodSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.ryutsu.rawValue) {
                ryutsuSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.depart.rawValue) {
                googleNewsSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.cosmetic.rawValue) {
                cosmeticSwitch.isOn = false
            }
            
            if !subscribeRss.contains(Rss.interior.rawValue) {
                interiorSwitch.isOn = false
            }
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        let subscribeRss: [Int] = summaryRss()
        
        if (subscribeRss.count == 0) {
            let alertController = UIAlertController(title: nil, message: "１つは選んでください！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                
            })
            alertController.addAction(okAction)
            alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(subscribeRss, forKey: "subscribeRss")
            
            let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
            let viewController: TabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            present(viewController, animated: true)
        }
        
    }
    
    private func summaryRss() -> [Int]{
        var subscribeRss: [Int] = []
        if googleNewsSwitch.isOn {
            subscribeRss.append(Rss.depart.rawValue)
        }
        if scSwitch.isOn {
            subscribeRss.append(Rss.sc.rawValue)
        }
        if apparelSwitch.isOn {
            subscribeRss.append(Rss.apparel.rawValue)
        }
        if eventcheckerSwitch.isOn {
            subscribeRss.append(Rss.eventchecker.rawValue)
        }
        if foodSwitch.isOn {
            subscribeRss.append(Rss.food.rawValue)
        }
        if ryutsuSwitch.isOn {
            subscribeRss.append(Rss.ryutsu.rawValue)
        }
        if cosmeticSwitch.isOn {
            subscribeRss.append(Rss.cosmetic.rawValue)
        }
        if interiorSwitch.isOn {
            subscribeRss.append(Rss.interior.rawValue)
        }
        return subscribeRss
    }
    
    @objc func back(sender: UIBarButtonItem) {
        let subscribeRss: [Int] = summaryRss()
        let userDefaults = UserDefaults.standard
        userDefaults.set(subscribeRss, forKey: "subscribeRss")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.needReloadPager = true
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
