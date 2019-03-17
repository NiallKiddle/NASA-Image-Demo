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
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var delegate: TextViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib() -> TextView {
        return UINib(nibName: "TextView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TextView
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
