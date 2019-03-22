//
//  TextView.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

class TextView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessibilityIdentifier = "textView"
        
        headerShadow()
    }
    
    class func instanceFromNib() -> TextView {
        return UINib(nibName: "TextView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TextView
    }
    
    // MARK: - Public functions
    open func configureView(for data: DataModel)
    {
        // Titlec label
        titleLabel.text = data.title!
        
        // Subtitle label with date and center
        let date = data.date_created!
        let center = data.center!
        subtitleLabel.text = "\(center) | \(date.formattedDateString())"
        
        // Inset description content
        descriptionTextView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Try to convert description to NSMutableAttributedString
        guard let attributedString = data.description!.htmlToAttributedString else {
            descriptionTextView.text = data.description!
            return
        }
        
        // Use attributed text to display formatted HTML
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: range)
        attributedString.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Light", size: 17)!, range: range)
        descriptionTextView.attributedText = attributedString
    }
}

// MARK: - Private functions
private extension TextView {
    
     func headerShadow()
     {
        // Header shadow
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowOffset = CGSize.zero
        headerView.layer.shadowRadius = 4
    }
}
