//
//  BlogosViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/14.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit

class BlogosViewController: UIViewController {

    static func instantiateViewController() -> BlogosViewController {
        let sb = UIStoryboard(name: "Blogos", bundle: nil)
        let v: BlogosViewController = sb.instantiateViewController(withIdentifier: "BlogosViewController") as! BlogosViewController
        v.title = "Blogos"
        return v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ブロゴス"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
