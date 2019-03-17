//
//  ImageModel.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import Foundation

// Conform model to Decodable to parse JSON
struct ImageModel: Decodable {
    let id: String
    let title: String
    let description: String
    let imageURL: String
    let center: String
    let date: String
    let keywords: [String]
}
