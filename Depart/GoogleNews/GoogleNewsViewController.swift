//
//  GoogleNewsViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/14.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit
import AlamofireImage

class GoogleNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var gooleNewsList: Array<GoogleNews> = []
    var request: RequestGoogleNews = RequestGoogleNews()
    private let refreshControl = UIRefreshControl()
    var isFavorite = false
    
    static func instantiateViewController(title: String, rssUrl: String, isFavorite: Bool = false) -> GoogleNewsViewController {
        let sb = UIStoryboard(name: "GoogleNews", bundle: nil)
        let vc: GoogleNewsViewController = sb.instantiateViewController(withIdentifier: "GoogleNewsViewController") as! GoogleNewsViewController
        vc.title = title
        vc.request.rssUrl = rssUrl
        vc.isFavorite = isFavorite
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
        
        self.table.register(UINib(nibName: "GoogleNewsWithoutImageTableViewCell", bundle: nil), forCellReuseIdentifier: "GoogleNewsWithoutImageTableViewCell")
        self.table.register(UINib(nibName: "GoogleNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "GoogleNewsTableViewCell")
        request.delegate = self
        if isFavorite {
             gooleNewsList = GoogleNews.getAll()
            self.table.reloadData()
        } else {
            request.request()
        }
        
        table.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        if request.rssUrl == "" {
            gooleNewsList = GoogleNews.getAll()
            self.table.reloadData()
            self.refreshControl.endRefreshing()
        } else {
            request.request()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gooleNewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let googleNews: GoogleNews = gooleNewsList[indexPath.row]

        if googleNews.image_url == "" {
            let cell:GoogleNewsWithoutImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GoogleNewsWithoutImageTableViewCell")! as! GoogleNewsWithoutImageTableViewCell
            cell.googleNews = googleNews
            return cell
        } else {
            let cell:GoogleNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GoogleNewsTableViewCell")! as! GoogleNewsTableViewCell
            cell.googleNews = googleNews
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let googleNews: GoogleNews = gooleNewsList[indexPath.row]
        if googleNews.image_url == "" {
            return 95
        } else {
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "WebView", bundle: nil)
        let viewController: WebViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let googleNews = gooleNewsList[indexPath.row]
        viewController.url = googleNews.url
        viewController.googleNews = googleNews
        present(viewController, animated: true, completion: nil)
    }
}

extension GoogleNewsViewController: RequestGoogleNewsProtocol {
    func done(response: Array<GoogleNews>) {
        gooleNewsList = response
        DispatchQueue.main.async(execute: { () -> Void in
            self.table.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
}
