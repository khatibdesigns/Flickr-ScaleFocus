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
    private var imageArray = [Photos]()
    private var totalPageNo = 1
    private var searchText = "Kitten"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            self.configureView()
    }

    func configureView() {
        
        createSearchBar()
        
        self.navigationItem.title = "Flickr Photos"
        
        self.flickrCollectionView.delegate = self
        self.flickrCollectionView.dataSource = self
        self.flickrCollectionView.register(UINib(nibName: "\(reuse_id)", bundle: nil), forCellWithReuseIdentifier: "\(reuse_id)")
        
        Client().fetchResults(text: "\(self.searchText)", completion: { (data) in
            self.imageArray = data.photo
            self.totalPageNo = data.pages
            
            self.flickrCollectionView.reloadData()
        }) {
            self.flickrCollectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageArray.count
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
        
        cell.model = Image.init(image: self.imageArray[indexPath.row])
        
        if indexPath.row == (self.imageArray.count - 10) {
            
            Threads.runInBackground {
                Client().fetchNextPage(text: self.searchText, totalPageNo: self.totalPageNo, completion: { (data) in
                self.imageArray.append(contentsOf: data.photo)
                DispatchQueue.main.async {
                          self.flickrCollectionView.reloadData()
                    
                       }
            }) {
               
                }
        }
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
    
    func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        searchBarController.dimsBackgroundDuringPresentation = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        self.searchText = text
        Client().fetchResults(text: "\(self.searchText)", completion: { (data) in
            self.imageArray = data.photo
            self.flickrCollectionView.reloadData()
        }) {
            self.flickrCollectionView.reloadData()
        }
        
        self.flickrCollectionView.reloadData()
        searchBarController.searchBar.resignFirstResponder()
    }
}
