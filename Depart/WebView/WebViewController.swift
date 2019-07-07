//
//  WebViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/29.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var url: String!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    var screenshotButton: UIBarButtonItem!
    var googleNews: GoogleNews?
    
    var webViewFrame: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.share))
        shareButton.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 0)
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(self.close))
        closeButton.imageInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0, right: 0)
        
        screenshotButton = UIBarButtonItem(title: "記事をスクショする！", style: .plain, target: self, action: #selector(screenshotButtonTapped))
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
    
    @IBAction func screenshotButtonTapped() {
        webViewFrame = webView.frame
        webView.frame = CGRect(x: webViewFrame.origin.x, y: webViewFrame.origin.y, width: webView.scrollView.contentSize.width, height: webView.scrollView.contentSize.height)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(screenshot), userInfo: nil, repeats: false)
        
    }
    
    @objc func screenshot() {
        UIGraphicsBeginImageContextWithOptions(webView.scrollView.contentSize, false, 0);
        self.webView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        webView.frame = webViewFrame
        if let googleNews = googleNews {
            let path = self.fileInDocumentsDirectory(filename: googleNews.guid) + ".png"
            let pngImageData = image.pngData()
            do {
                try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
                
                let screenshot = Screenshot.create(googleNews: googleNews, fileName: googleNews.guid)
                let realm = try! Realm()
                try! realm.write {
                    realm.add(screenshot)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
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
