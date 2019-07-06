//
//  Screenshot.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/07/06.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation
import RealmSwift

class Screenshot: Object {
    @objc dynamic var title: String!
    @objc dynamic var date: String!
    @objc dynamic var fileName: String!
    
    static func create(googleNews: GoogleNews, fileName: String) -> Screenshot{
        let screenshot = Screenshot()
        screenshot.title = googleNews.title
        screenshot.date = googleNews.formattedDate()
        screenshot.fileName = fileName
        
        return screenshot
    }
}
