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
    
    var pagesArray: [UIView] = []
    
    // Views
    var imageView = ImageView.instanceFromNib()
    var textView = TextView.instanceFromNib()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
    }
}

private extension ImageViewController {
    func setupScrollView()
    {
        // Add pages to scroll view
        pagesArray.append(imageView)
        pagesArray.append(textView)
        
        for (index, page) in pagesArray.enumerated()
        {
            let xPosition: CGFloat = view.frame.width * CGFloat(index)
            page.frame = CGRect(x: xPosition, y: 0, width: view.frame.width, height: view.frame.height)
            
            scrollView.addSubview(page)
        }
        
        // Setup scroll view size for pages
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pagesArray.count), height: view.frame.height)
        scrollView.contentOffset.x = view.frame.width
    }
}
