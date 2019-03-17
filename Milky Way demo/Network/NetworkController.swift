//
//  NetworkController.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import Foundation
import UIKit

class NetworkController {
    
    public let endpoint = "https://images-api.nasa.gov/search?q=milky%20way&media_type=image&year_start=2017&year_end=2017"
    
    private let imageCache = NSCache<NSString, UIImage>()// Temporarily store images during session
    private var imageUrlString: String? // used to ensure cell loads correct image
    
    // MARK: - Public functions
    public func fetchObjects(from url: URL, completionHandler: @escaping ([ItemModel]?) ->())
    {
        // Fetch data from API endpoint
        fetchData(from: url) { (data) in
            guard data != nil else {
                completionHandler(nil)
                return
            }
            
            // Decode JSON response
            completionHandler(self.decodeJSONFrom(data!))
        }
    }
    
    public func loadImageUsing(urlString: String, completionHandler: @escaping (UIImage?) ->())
    {
        // Temp store image URL
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString)
        {
            completionHandler(imageFromCache)
            return
        }
        
        fetchData(from: url!) { (data) in
            let imageToCache = UIImage(data: data!)
            
            // Ensure returning correct image
            if self.imageUrlString == urlString {
                completionHandler(imageToCache)
            }
            
            self.imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            return
        }
    }
    
    // MARK: - Private functions
    private func fetchData(from url: URL, completionHandler: @escaping (Data?) ->())
    {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }.resume()
    }
    
    private func decodeJSONFrom(_ data: Data) -> [ItemModel]?
    {
        do {
            let responseData = try JSONDecoder().decode(ResponseModel.self, from: data)
            guard responseData.collection != nil else { return nil }
            
            return responseData.collection!.items
        } catch let JSONErr {
            print("JSON Error: ", JSONErr)
            return nil
        }
    }
}
