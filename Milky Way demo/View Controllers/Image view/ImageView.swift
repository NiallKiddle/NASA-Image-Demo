//
//  ImageView.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

class ImageView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessibilityIdentifier = "imageView"
    }
    
    class func instanceFromNib() -> ImageView {
        return UINib(nibName: "ImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ImageView
    }
    
    // MARK: - Public functions
    open func configureView(for data: DataModel, image: UIImage)
    {
        // Title label
        titleLabel.text = data.title!
        
        // Fullscreen image
        backgroundImageView.image = image
        
        // Subtitle label with date and center
        let date = data.date_created!
        let center = data.center!
        subtitleLabel.text = "\(center) | \(date.formattedDateString())"
    }
}
