//
//  PhotoCollectionViewController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/20/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import Material

class PhotoCollectionViewController: UIViewController {
    fileprivate var collectionView: UICollectionView!
    fileprivate var images = [UIImage]()
    fileprivate let dataBaseManager = DatabaseManager.shared
    var allObjects: [SutraObject] = [SutraObject]()
    private var showingBack = false
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        isMotionEnabled = true
        view.backgroundColor = .white
        getObjects()
        prepareCollectionView()
        prepareNavigationBar()
    }
}

extension PhotoCollectionViewController {
    func getObjects() {
        guard let sutraRef = dataBaseManager?.getObjectRef(path: "pics") else {return}
        sutraRef.observe(.childAdded, with: { (snapshot) -> Void in
            let object = SutraObject(snapshot: snapshot)!
            self.allObjects.append(object)
            if let image = self.dataBaseManager?.getImageFromLocalFile(fileURL: "\(object.title).png") {
                self.images.append(image)
                self.collectionView.reloadData()
            } else {
                self.dataBaseManager?.downloadImageLocaly(imageName: object.title, completion: { (image) in
                    if let image = image {
                        self.images.append(image)
                        self.collectionView.reloadData()
                    }
                })
            }
        })
    }
}

extension PhotoCollectionViewController {
    
    fileprivate func prepareCollectionView() {
        let columns: CGFloat = .phone == Device.userInterfaceIdiom ? 4 : 11
        let w: CGFloat = (view.bounds.width - columns - 1) / columns
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: w, height: w)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        view.layout(collectionView).horizontally().top().bottom()
        
        collectionView.reloadData()
    }
    
    fileprivate func prepareNavigationBar() {
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.image = images[indexPath.item]
        cell.imageView.motionIdentifier = allObjects[indexPath.item].title
        cell.transition(.fadeOut, .scale(0.75))
        
        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate {
    @objc
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: PhotoViewController(images: images, index: indexPath.item), completion: nil)
    }
}
