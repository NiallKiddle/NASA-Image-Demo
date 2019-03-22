//
//  InfoModel.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import Foundation

// Conform model to Decodable to parse JSON
struct DataModel: Decodable {
    let title: String?
    let date_created: String?
    let center: String?
    let description: String?
    let location: String?
    let media_type: String?
    let keywords: [String]?
    let nasa_id: String?
    
    init(title: String, date_created: String, center: String, description: String, location: String, media_type: String, keywords: [String], nasa_id: String) {
        self.title = title
        self.date_created = date_created
        self.center = center
        self.description = description
        self.location = location
        self.media_type = media_type
        self.keywords = keywords
        self.nasa_id = nasa_id
    }
}
