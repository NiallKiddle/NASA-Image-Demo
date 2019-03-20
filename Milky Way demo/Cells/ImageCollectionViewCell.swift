//
//  ImageCollectionViewCell.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 16/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    // Cell attributes
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // Loading attributes
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let network = NetworkController()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset cell if necessary
        imageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
    }
}

// MARK: - Public functions
extension ImageCollectionViewCell {
    
    func cellImage(hasLoaded: Bool)
    {
        guard hasLoaded else {
            // Still loading attributes
            loadingView.alpha = 1
            activityIndicator.startAnimating()
            return
        }
        
        // Cell has loaded
        activityIndicator.stopAnimating()
        
        // Gently reveal cell
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.loadingView.alpha = 0
        })
    }
}

// MARK: - Private functions
private extension ImageCollectionViewCell {
    
    func setupCell()
    {
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
}
