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

class ViewController: UIViewController {
    
    let pagingViewController = CustomPagingViewController(viewControllers: [
        GoogleNewsViewController.instantiateViewController(title: "百貨店", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Departs.json"),
        GoogleNewsViewController.instantiateViewController(title: "SC", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/SC.json"),
        GoogleNewsViewController.instantiateViewController(title: "アパレル", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Apparel.json"),
        GoogleNewsViewController.instantiateViewController(title: "イベント", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/EventChecker.json"),
        GoogleNewsViewController.instantiateViewController(title: "食品", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Foods.json"),
        GoogleNewsViewController.instantiateViewController(title: "流通", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Ryutsuu.json"),
        GoogleNewsViewController.instantiateViewController(title: "化粧品", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Cosmetics.json"),
        GoogleNewsViewController.instantiateViewController(title: "インテリア", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Interior.json"),
        GoogleNewsViewController.instantiateViewController(title: "お気に入り", rssUrl: "", isFavorite: true)
    ])
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingViewController.borderOptions = .hidden
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.indicatorColor = UIColor(white: 0, alpha: 0.4)
        pagingViewController.textColor = UIColor(white: 1, alpha: 0.6)
        pagingViewController.selectedTextColor = .white
        
        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        // Set the menu view as the title view on the navigation bar. This
        // will remove the menu view from the view hierachy and put it
        // into the navigation bar.
        navigationItem.titleView = pagingViewController.collectionView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationItem.titleView?.frame = CGRect(origin: .zero, size: navigationBar.bounds.size)
        pagingViewController.menuItemSize = .fixed(width: 100, height: navigationBar.bounds.height)
    }
}
