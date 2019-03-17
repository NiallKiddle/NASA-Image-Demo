//
//  HeaderView.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 16/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

// MARK: - Delegate
protocol HeaderViewDelegate {
    
}

// MARK: - Header state
enum HeaderState {
    case closed
    case open
}

extension HeaderState {
    var opposite: HeaderState {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

class HeaderView: UIView {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var textConstraint: NSLayoutConstraint!
    
    // Private variables
    private var delegate: HeaderViewDelegate!
    
    // Public variables
    public let closedConstraint: CGFloat = 0
    public let openConstraint: CGFloat = 58
    
    public let openHeight: CGFloat = 160
    public let closedHeight: CGFloat = 100
    
    public var currentState: HeaderState = .open
    
    override func awakeFromNib() {
        setupView()
    }
    
    class func instanceFromNib() -> HeaderView {
        return UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HeaderView
    }
}

// MARK: - Private functions
private extension HeaderView {
    
    func setupView()
    {
        // Search view
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = 12
    }
}
