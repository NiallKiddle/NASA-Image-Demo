//
//  HomeViewController
//  Milky Way demo
//
//  Created by Niall Kiddle on 16/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let network = NetworkController()
    
    // Views
    private let headerView = HeaderView.instanceFromNib()
    
    // Private variables
    private var imageURLArray: [String] = ["","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    private let numberOfCellsPerRow: CGFloat = 1
    private let endPoint = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
        setupCollectionView()
        fetchImages()
    }
}

// MARK: - Private Functions
private extension HomeViewController {
    
    func layoutViews()
    {
        // Header layout
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerView.openHeight)
        view.addSubview(headerView)
        
        // UICollectionView layout
        collectionView.frame = CGRect(x: 20, y: headerView.openHeight, width: view.frame.width - 40, height: view.frame.height - headerView.openHeight)
    }
    
    func setupCollectionView()
    {
        let imageNib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(imageNib, forCellWithReuseIdentifier: "imageCollectionViewCell")
        
        // Layout UICollectionView for cells per row
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (collectionView.frame.width - max(0, numberOfCellsPerRow - 1) * horizontalSpacing) / numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
    }
}

// MARK: - UICollectionView implementation
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLArray != nil ? imageURLArray.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
}

// MARK: - UIScrollView handlers
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    {
        let yVelocity = scrollView.panGestureRecognizer.velocity(in: view).y
        
        if yVelocity > 0
        {
            // Scrolling up
            animateHeader(to: .open, duration: 0.3)
            return
        }
        
        // Scrolling down
        animateHeader(to: .closed, duration: 0.3)
    }
}



// MARK: - UIViewPropertyAnimator implementation
extension HomeViewController {
    
    public func animateHeader(to state: HeaderState, duration: TimeInterval)
    {
        // an animator for the transition
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            switch state {
            case .open:
                self.headerView.textConstraint.constant = self.headerView.openConstraint
                self.headerView.searchView.alpha = 1
                self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.headerView.openHeight)
                
                self.collectionView.frame = CGRect(x: 0, y: self.headerView.openHeight, width: self.view.frame.width, height: self.view.frame.height - self.headerView.openHeight)
                break
                
            case .closed:
                self.headerView.textConstraint.constant = self.headerView.closedConstraint
                self.headerView.searchView.alpha = 0
                self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.headerView.closedHeight)
                
                self.collectionView.frame = CGRect(x: 0, y: self.headerView.closedHeight, width: self.view.frame.width, height: self.view.frame.height - self.headerView.closedHeight)
                break
            }
            
            self.headerView.layoutIfNeeded()
        })
    }
}

// MARK: - Network
private extension HomeViewController {
    
    func fetchImages()
    {
        guard let url = URL(string: network.endpoint) else { return }
        
        
    }
}
