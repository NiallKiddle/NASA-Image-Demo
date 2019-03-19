//
//  StringExtension.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 19/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

extension String {
    
    // Convert regular String HTML to Attributed String
    public var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSMutableAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
    
    // Convert string as expected date to new format
    public func formattedDateString() -> String
    {
        // Expected date format
        let expectedFormatter = DateFormatter()
        expectedFormatter.dateFormat = "yyyy-MM-dd"
        
        // New date format
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, yyyy"
        
        
        // If string matches expected format, convert to new format
        if let date = expectedFormatter.date(from: String(self.prefix(10)))
        {
            return newFormatter.string(from: date)
        }
        
        // Format failed
        return self
    }
}
