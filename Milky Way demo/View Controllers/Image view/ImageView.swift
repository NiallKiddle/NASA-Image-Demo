//
//  ImageView.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

protocol ImageViewDelegate {
    func imageCancelPressed()
    func imageDownPressed()
}

class ImageView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var delegate: ImageViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib() -> ImageView {
        return UINib(nibName: "ImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ImageView
    }
}

// MARK: - Actions
extension ImageView {
    
    @IBAction func cancelPressed(_ sender: UIButton)
    {
        guard delegate != nil else { return }
        delegate.imageCancelPressed()
    }
    
    @IBAction func downPressed(_ sender: UIButton)
    {
        guard delegate != nil else { return }
        delegate.imageDownPressed()
    }
}
