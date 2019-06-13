//
//  ViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/14.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import UIKit
import Parchment

class CustomPagingView: PagingView {
    
    override func setupConstraints() {
        // Use our convenience extension to constrain the page view to all
        // of the edges of the super view.
        constrainToEdges(pageView)
    }
}

// Create a custom paging view controller and override the view with
// our own custom subclass.
class CustomPagingViewController: FixedPagingViewController {
    override func loadView() {
        view = CustomPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view)
    }
}

class PagingViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        let userDefaults = UserDefaults.standard
        let subscribeRss: [Int]? = userDefaults.array(forKey: SelectRssTableViewController.SUBSCRIBE_RSS) as? [Int]
        var viewcontrollers: [GoogleNewsViewController] = []
        if let subscribeRss = subscribeRss {
            for rss in subscribeRss {
                if let r: Rss = Rss(rawValue: rss) {
                    viewcontrollers.append(r.viewcontroller())
                }
            }
        }
        
        pagingViewController = CustomPagingViewController(viewControllers: viewcontrollers)
    }
    
    var pagingViewController:FixedPagingViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.needReloadPager {
            makePaging()
            appDelegate.needReloadPager = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePaging()
    }
    
    private func makePaging() {
        let userDefaults = UserDefaults.standard
        let subscribeRss: [Int]? = userDefaults.array(forKey: SelectRssTableViewController.SUBSCRIBE_RSS) as? [Int]
        var viewcontrollers: [GoogleNewsViewController] = []
        if let subscribeRss = subscribeRss {
            for rss in subscribeRss {
                if let r: Rss = Rss(rawValue: rss) {
                    viewcontrollers.append(r.viewcontroller())
                }
            }
        }
        
        pagingViewController = CustomPagingViewController(viewControllers: viewcontrollers)
        pagingViewController.borderOptions = .hidden
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.indicatorColor = UIColor(white: 0, alpha: 0.4)
        pagingViewController.textColor = UIColor(white: 1, alpha: 0.6)
        pagingViewController.selectedTextColor = .white
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        navigationItem.titleView = pagingViewController.collectionView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationItem.titleView?.frame = CGRect(origin: .zero, size: navigationBar.bounds.size)
        pagingViewController.menuItemSize = .fixed(width: 100, height: navigationBar.bounds.height)
    }
}
