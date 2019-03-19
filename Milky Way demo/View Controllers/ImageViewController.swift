//
//  ImageViewController.swift
//  Milky Way demo
//
//  Created by Niall Kiddle on 17/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Public properties
    public var objectData: DataModel!
    public var objectImage: UIImage!
    
    // Private properties
    private var pagesArray: [UIView] = []
    private var currentIndex: CGFloat = 0
    
    // Views
    var imageView = ImageView.instanceFromNib()
    var textView = TextView.instanceFromNib()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupViews()
    }
}

private extension ImageViewController {
    func setupScrollView()
    {
        // Add vertical pages to scroll view
        pagesArray.append(imageView)
        pagesArray.append(textView)
        
        for (index, page) in pagesArray.enumerated()
        {
            let yPosition: CGFloat = view.frame.height * CGFloat(index)
            page.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
            
            scrollView.addSubview(page)
        }
        
        // Setup scroll view size for pages
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * CGFloat(pagesArray.count))
    }
    
    func setupViews()
    {
        guard objectData != nil else { return }
        guard objectImage != nil else { return }
        
        // Image view
        imageView.configureView(for: objectData, image: objectImage)
        imageView.downButton.addTarget(self, action: #selector(imageDownPressed(_:)), for: .touchUpInside)
        imageView.cancelButton.addTarget(self, action: #selector(imageCancelPressed(_:)), for: .touchUpInside)
        
        // Text view
        textView.configureView(for: objectData)
        textView.upButton.addTarget(self, action: #selector(textUpPressed(_:)), for: .touchUpInside)
        textView.cancelButton.addTarget(self, action: #selector(textCancelPressed(_:)), for: .touchUpInside)
    }
    
    func resetPosition()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
    }
}

// MARK: - TextViewDelegate button handlers
extension ImageViewController {
    
    @objc func textCancelPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textUpPressed(_ sender: UIButton)
    {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
}

// MARK: - ImageViewDelegate button handlers
extension ImageViewController {
    
    @objc func imageCancelPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imageDownPressed(_ sender: UIButton)
    {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: self.view.frame.height)
        })
    }
}

// MARK: - UIScrollViewDelegate implementation
extension ImageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        // Update current page index
        let scrollOffset = scrollView.contentOffset.x / scrollView.frame.size.width
        currentIndex = round(scrollOffset)
    }
}
