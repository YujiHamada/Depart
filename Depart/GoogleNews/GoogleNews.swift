//
//  GoogleNews.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/01/18.
//  Copyright © 2019年 濱田裕史. All rights reserved.
//

import Foundation
import RealmSwift

class GoogleNews: Object, Codable {
    @objc dynamic var title: String
    @objc dynamic var url: String
    @objc dynamic var guid: String
    @objc dynamic var date: Int // unix timestamp
    @objc dynamic var source: String
    @objc dynamic var image_url: String
    @objc dynamic var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case title
        case url
        case guid
        case date
        case source
        case image_url
    }
    
    func formattedDate() -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(self.date))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let formatedDate = formatter.string(from: date)
        
        return formatedDate
    }
    
    override static func primaryKey() -> String? {
        return "guid"
    }
    
    static func getAll() -> Array<GoogleNews>{
        let realm = try! Realm()
        let googleNewsList = realm.objects(GoogleNews.self).filter("isFavorite == true")
        return Array(googleNewsList);
    }
}

protocol RequestGoogleNewsProtocol {
    func done(response: Array<GoogleNews>) -> Void
}

struct RequestGoogleNews {
    var delegate: RequestGoogleNewsProtocol?
    var rssUrl: String!
    
    func request() {
        let url = URL(string: rssUrl)!
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let googleNewsList = try! JSONDecoder().decode(Array<GoogleNews>.self, from: data)
            self.delegate?.done(response: googleNewsList)
        }
        task.resume()
    }
}
