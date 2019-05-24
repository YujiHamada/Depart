//
//  WebViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/29.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var url: String!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.share))
        shareButton.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 30)
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(self.close))
        closeButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0, right: 15)
        
        bottomToolbar.items = [flexible, shareButton, closeButton]
        
        if let safeAreaInsetsTop = UIApplication.shared.delegate?.window??.safeAreaInsets.top {
            bottomToolbar.frame = CGRect(x: bottomToolbar.frame.origin.x, y: bottomToolbar.frame.origin.y, width: bottomToolbar.frame.size.width, height: bottomToolbar.frame.size.height +  safeAreaInsetsTop)
        }

    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func share() {
        let shareText = webView.title
        let shareWebsite = NSURL(string: url)!
        
        let activityItems = [shareText!, shareWebsite] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
    }
}
