//
//  SimpleWebViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/07/06.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import WebKit

class SimpleWebViewController: UIViewController {

    private var webView: WKWebView!
    var urlString: String!
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//    }
    
    convenience init(url: String) {
        self.init(nibName: nil, bundle: nil)
        self.urlString = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame:CGRect(x:0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height))
        
        let url = URL(string: urlString)
        let request = NSURLRequest(url: url! as URL)
        
        webView.load(request as URLRequest)
        
        self.view.addSubview(webView)
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
