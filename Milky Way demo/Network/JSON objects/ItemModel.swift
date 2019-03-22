//
//  ImageModel.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import Foundation

// Conform model to Decodable to parse JSON
struct ItemModel: Decodable {
    let href: String?
    let data: [DataModel]?
    let links: [LinksModel]?
    
    init(href: String, data: [DataModel], links: [LinksModel]) {
        self.href = href
        self.data = data
        self.links = links
    }
}
