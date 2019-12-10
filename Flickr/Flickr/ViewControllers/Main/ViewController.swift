//
//  ViewController.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flickrCollectionView: UICollectionView!
    private var searchBarController: UISearchController!
    private var columnCount: CGFloat = Statics.ColumnCount
    private var reuse_id = "ImageCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            self.configureView()
            self.viewModelClosures()
    }

    func configureView() {
        
        createSearchBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        self.navigationItem.title = "Flickr Photos"
        
        self.flickrCollectionView.register(UINib(nibName: "\(reuse_id)", bundle: nil), forCellWithReuseIdentifier: "\(reuse_id)")
        self.flickrCollectionView.delegate = self
        self.flickrCollectionView.dataSource = self
        
        Client().get(text: "Kitten") { }
    }
}

extension ViewController {
    
    fileprivate func viewModelClosures() {
        
        self.searchBarController.isActive = false
        
        Client().dataUpdated = { [weak self] in
            self?.flickrCollectionView.reloadData()
        }
    }
    
    private func loadNextPage() {
        Client().fetchNextPage {}
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Client().imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(reuse_id)", for: indexPath) as! ImageCollectionViewCell
        
            cell.cellImageView.image = nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell else {
            return
        }
        
        cell.model = Image.init(image: Client().imageArray[indexPath.row])
        
        if indexPath.row == (Client().imageArray.count - 10) {
            Client().fetchNextPage {}
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width)/columnCount, height: (collectionView.bounds.width)/columnCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        self.flickrCollectionView.reloadData()
        
        Client().get(text: text) { }
        
        searchBarController.searchBar.resignFirstResponder()
    }
    
}
