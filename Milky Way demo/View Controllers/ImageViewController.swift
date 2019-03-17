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
    
    // Public variables
    public var objectData: DataModel!
    public var objectImage: UIImage!
    
    // Private variables
    private var pagesArray: [UIView] = []
    
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
        imageView.delegate = self
        imageView.configureView(for: objectData, image: objectImage)
        
        // Text view
        textView.delegate = self
        textView.configureView(for: objectData)
        
        // Data and center label
        let date = objectData.date_created!
        let center = objectData.center!
        textView.subtitleLabel.text = "\(center) | \(date)"
    }
}

// MARK: - TextViewDelegate Implementation
extension ImageViewController: TextViewDelegate {
    
    func textCancelPressed()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func textUpPressed()
    {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
}

// MARK: - TextViewDelegate Implementation
extension ImageViewController: ImageViewDelegate {
    
    func imageCancelPressed()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imageDownPressed()
    {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: self.view.frame.height)
        })
    }
}
