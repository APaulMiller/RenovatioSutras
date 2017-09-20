//
//  PhotoViewController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/20/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import Material

class PhotoViewController: UIViewController {
    fileprivate var collectionView: CollectionView!
    fileprivate let dataBaseManager = DatabaseManager.shared
    var allObjects: [SutraObject] = [SutraObject]()
    var dataSourceItems = [DataSourceItem]()
    
    fileprivate var fabButton: FABButton!
    
    fileprivate var index: Int
    
    public required init?(coder aDecoder: NSCoder) {
        index = 0
        super.init(coder: aDecoder)
    }
    
    public init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        preparePhotos()
        prepareFABButton()
        prepareCollectionView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareNavigationBar()
    }
}

extension PhotoViewController {
    
    fileprivate func preparePhotos() {
        guard let sutraRef = dataBaseManager?.getObjectRef(path: "pics") else {return}
        sutraRef.observe(.childAdded, with: { (snapshot) -> Void in
            let object = SutraObject(snapshot: snapshot)!
            self.allObjects.append(object)
            if let image = self.dataBaseManager?.getImageFromLocalFile(fileURL: "\(object.title).png") {
                self.dataSourceItems.append(DataSourceItem(data: image, width: self.view.bounds.width))
            } else {
                self.dataBaseManager?.downloadImageLocaly(imageName: object.title, completion: { (image) in
                    if let image = image {
                        self.dataSourceItems.append(DataSourceItem(data: image, width: self.view.bounds.width))
                    }
                })
            }
        })
    }
    
    fileprivate func prepareFABButton() {
        fabButton = FABButton(image: Icon.cm.moreHorizontal, tintColor: .white)
        fabButton.pulseColor = .white
        fabButton.backgroundColor = Color.red.base
        fabButton.motionIdentifier = "options"
        view.layout(fabButton).width(64).height(64).bottom(24).right(24)
    }
    
    fileprivate func prepareCollectionView() {
        collectionView = CollectionView()
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        view.layout(collectionView).center().width(view.bounds.width).height(350)
        
        collectionView.scrollRectToVisible(CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width, height: 350), animated: false)
    }
    
    fileprivate func prepareNavigationBar() {
    }
}

extension PhotoViewController: CollectionViewDataSource {
    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceItems.count
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        guard let image = dataSourceItems[indexPath.item].data as? UIImage else {
            return cell
        }
        
        cell.imageView.image = image
        cell.imageView.motionIdentifier = allObjects[indexPath.item].title
        
        return cell
    }
}

extension PhotoViewController: CollectionViewDelegate {
    
}
