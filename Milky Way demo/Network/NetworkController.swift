//
//  NetworkController.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import Foundation

class NetworkController {
    
    public let endpoint = "https://images-api.nasa.gov/search?q=milky%20way&media_type=image&year_start=2017&year_end=2017"
    
    // MARK: - Public functions
    public func fetchImages(from url: URL, completionHandler: @escaping ([ImageModel]?) ->())
    {
        // Fetch data from API endpoint
        fetchData(from: url) { (data) in
            guard data != nil else {
                completionHandler(nil)
                return
            }
            
            // Decode JSON response
            self.decodeJSONFrom(data!)
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
    
    private func decodeJSONFrom(_ data: Data)
    {
        do {
//            let test = JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: data)
            
        } catch let JSONErr {
            print("JSON Error: ", JSONErr)
        }
    }
}
