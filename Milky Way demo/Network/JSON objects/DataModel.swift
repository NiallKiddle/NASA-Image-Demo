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
}
