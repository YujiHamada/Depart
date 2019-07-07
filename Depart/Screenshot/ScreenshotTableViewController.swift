//
//  ScreenshotTableViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/07/06.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import RealmSwift

class ScreenshotTableViewController: UITableViewController {

    var screenShots: Results<Screenshot>?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        let realm = try! Realm()
        screenShots = realm.objects(Screenshot.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(screenShots![indexPath.row])
            }
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenShots?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ImageView", bundle: nil)
        let vc: ImageViewController = sb.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        let screenShot = screenShots![indexPath.row]
        let image = UIImage(contentsOfFile: fileInDocumentsDirectory(filename: screenShot.fileName))
        vc.imageView.frame = CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.size.width, height: (image?.size.height)! / UIScreen.main.scale)
        vc.imageView.image = UIImage(contentsOfFile: fileInDocumentsDirectory(filename: screenShot.fileName))
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScreenshotTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ScreenshotTableViewCell", for: indexPath) as! ScreenshotTableViewCell
        cell.screenshot = screenShots![indexPath.row]

        return cell
    }

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
