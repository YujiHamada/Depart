//
//  Rss.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/06/08.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation

enum Rss:Int {
    case depart = 1
    case sc = 2
    case apparel = 3
    case eventchecker = 4
    case food = 5
    case ryutsu = 6
    case cosmetic = 7
    case interior = 8
    
    func viewcontroller() -> GoogleNewsViewController {
        switch self {
        case .depart:
            return GoogleNewsViewController.instantiateViewController(title: "百貨店", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Departs.json")
        case .sc:
            return GoogleNewsViewController.instantiateViewController(title: "SC", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/SC.json")
        case .apparel:
            return GoogleNewsViewController.instantiateViewController(title: "アパレル", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Apparel.json")
        case .eventchecker:
            return GoogleNewsViewController.instantiateViewController(title: "イベント", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/EventChecker.json")
        case .food:
            return GoogleNewsViewController.instantiateViewController(title: "イベント", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/EventChecker.json")
        case.ryutsu:
            return GoogleNewsViewController.instantiateViewController(title: "イベント", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/EventChecker.json")
        case.cosmetic:
            return GoogleNewsViewController.instantiateViewController(title: "化粧品", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Cosmetics.json")
        case .interior:
            return GoogleNewsViewController.instantiateViewController(title: "インテリア", rssUrl: "https://s3-ap-northeast-1.amazonaws.com/depart-rss/Interior.json")
        }
    }
    
}
