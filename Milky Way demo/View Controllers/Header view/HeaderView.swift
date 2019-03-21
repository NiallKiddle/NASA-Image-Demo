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
    func searchDidUpdate(with text: String)
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
    @IBOutlet weak var dataLabel: UILabel!
    
    public var delegate: HeaderViewDelegate!
    
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
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = 12
        
        searchTextField.delegate = self
        
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 4
    }
}

// MARK: - UITextFieldDelegate implementation
extension HeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Dismiss keyboard on return
        if searchTextField.isFirstResponder { searchTextField.resignFirstResponder() }
        return false
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField)
    {
        guard let text = sender.text else { return }
        guard delegate != nil else { return }
        
        // Update search every character change
        delegate.searchDidUpdate(with: text)
    }
}
