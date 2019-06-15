//
//  WebViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/29.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var url: String!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    var screenshotButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.share))
        shareButton.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 0)
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(self.close))
        closeButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0, right: 0)
        
        screenshotButton = UIBarButtonItem(title: "記事をスクショする！", style: .plain, target: self, action: #selector(screenshot))
        screenshotButton.isEnabled = false

        closeButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0, right: 0)
        
        bottomToolbar.items = [flexible, screenshotButton, flexible, shareButton, flexible, closeButton]
        
        if let safeAreaInsetsTop = UIApplication.shared.delegate?.window??.safeAreaInsets.top {
            bottomToolbar.frame = CGRect(x: bottomToolbar.frame.origin.x, y: bottomToolbar.frame.origin.y, width: bottomToolbar.frame.size.width, height: bottomToolbar.frame.size.height +  safeAreaInsetsTop)
        }

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        screenshotButton.isEnabled = true
    }
    
    @IBAction func screenshot() {
        let webViewFrame = webView.frame
        webView.frame = CGRect(x: webViewFrame.origin.x, y: webViewFrame.origin.y, width: webView.scrollView.contentSize.width, height: webView.scrollView.contentSize.height)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(s), userInfo: nil, repeats: false)
    }
    
    @objc func s() {
        UIGraphicsBeginImageContextWithOptions(webView.scrollView.contentSize, false, 0);
        self.webView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
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
