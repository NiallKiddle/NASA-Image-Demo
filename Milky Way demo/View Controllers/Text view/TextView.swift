//
//  TextView.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

protocol TextViewDelegate {
    func textCancelPressed()
    func textUpPressed()
}

class TextView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var headerView: UIView!
    
    var delegate: TextViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerShadow()
    }
    
    class func instanceFromNib() -> TextView {
        return UINib(nibName: "TextView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TextView
    }
    
    // MARK: - Public functions
    open func configureView(for data: DataModel)
    {
        titleLabel.text = data.title!
        descriptionTextView.text = data.description!
        descriptionTextView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let date = data.date_created!
        let center = data.center!
        subtitleLabel.text = "\(center) | \(date)"
    }
}

// MARK: - Private functions
private extension TextView {
    
     func headerShadow()
     {
        // Shadow
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowOffset = CGSize.zero
        headerView.layer.shadowRadius = 4
    }
}

// MARK: - Actions
extension TextView {
    
    @IBAction func cancelPressed(_ sender: UIButton)
    {
        guard delegate != nil else { return }
        delegate.textCancelPressed()
    }
    
    @IBAction func upPressed(_ sender: UIButton)
    {
        guard delegate != nil else { return }
        delegate.textUpPressed()
    }
}
