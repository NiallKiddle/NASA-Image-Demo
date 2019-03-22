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
    @IBOutlet weak var dataLabel: UILabel!
    
    private var selectedData: DataModel!
    private var selectedImage: UIImage!
    
    // Views
    private let headerView = HeaderView.instanceFromNib()
    
    // Properties
    var itemArray: [ItemModel] = []
    private var savedArray: [ItemModel] = [] // Stores items from itemArray for when removing search filter
    private let numberOfCellsPerRow: CGFloat = 1
    private let endPoint = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "homeView"
        
        layoutViews()
        setupCollectionView()
        fetchJSON()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueImageVC"
        {
            guard let destination = segue.destination as? ImageViewController else { return }
            guard selectedData != nil && selectedImage != nil else { return }
            
            // Prepare next view properties
            destination.objectData = selectedData
            destination.objectImage = selectedImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Prevent potential memory leaks with image cache
        NetworkController.shared.clearCache()
    }
}

// MARK: - Private Functions
private extension HomeViewController {
    
    func layoutViews()
    {
        // Header layout
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerView.openHeight)
        headerView.delegate = self
        headerView.accessibilityIdentifier = "headerView"
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
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        collectionView.accessibilityIdentifier = "collectionView"
        
        // Dismiss keyboard when scroll
        collectionView.keyboardDismissMode = .onDrag
        
        // Layout UICollectionView for cells per row
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (collectionView.frame.width - max(0, numberOfCellsPerRow - 1) * horizontalSpacing) / numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.8)
            flowLayout.minimumLineSpacing = 20
        }
    }
}

// MARK: - UICollectionView implementation
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        // Prepare data
        let object = itemArray[indexPath.item]
        guard let data = object.data?[0] else { return cell }
        guard let link = object.links?[0], let urlString = link.href else { return cell }
        
        // Assign data to model
        cell.data = data
        cell.loadImage(with: urlString)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = itemArray[indexPath.item]
        guard let data = object.data?.first! else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        
        // Check if the image had loaded
        if cell.imageView.image == nil { return }
        
        selectedData = data
        selectedImage = cell.imageView.image
        
        performSegue(withIdentifier: "segueImageVC", sender: self)
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

// MARK: - HeaderViewDelegate implementation
extension HomeViewController: HeaderViewDelegate {
    
    func searchDidUpdate(with text: String)
    {
        // Return items to original array
        itemArray = savedArray
        
        guard text != "" else {
            collectionView.reloadData()
            
            headerView.dataLabel.text = "Showing \(savedArray.count) results"
            return
        }
        
        // Filter for search term
        let filtered = itemArray.filter {
            $0.data!.first!.title!.localizedLowercase.contains(text.localizedLowercase)
        }
        
        itemArray = filtered
        collectionView.reloadData()
        
        let filteredCount = itemArray.count
        headerView.dataLabel.text = filteredCount == 0 ? "No results found for '\(text)'" : "Showing \(filteredCount) results for '\(text)'"
    }
}

// MARK: - API fetch
private extension HomeViewController {
    
    func fetchJSON()
    {
        guard let url = URL(string: NetworkController.shared.endpoint) else { return }
        
        // Update
        headerView.dataLabel.text = "Fetching images"
        dataLabel.text = "Loading..."
        dataLabel.alpha = 1
        
        // Make call to API
        NetworkController.shared.fetchObjects(from: url) { (objects) in
            guard let objects = objects else {
                
                DispatchQueue.main.async {
                    self.headerView.dataLabel.text = "Error"
                    self.dataLabel.text = "Could not load images from API"
                }
                
                return
            }
            
            self.itemArray = objects
            self.savedArray = self.itemArray
            
            DispatchQueue.main.async {
                self.headerView.dataLabel.text = "Showing \(self.savedArray.count) results"
                self.dataLabel.text = ""
                self.dataLabel.alpha = 0
                
                self.collectionView.reloadData()
            }
        }
    }
}
