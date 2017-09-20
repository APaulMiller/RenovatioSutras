//
//  PhotoViewController.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/20/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import UIKit
import Material

class PhotoViewController: UIViewController, UIGestureRecognizerDelegate {
    fileprivate var collectionView: CollectionView!
    fileprivate let dataBaseManager = DatabaseManager.shared
    var dataSourceItems = [DataSourceItem]()
    fileprivate var images = [UIImage]()
    fileprivate var fabButton: FABButton!
    var allObjects: [SutraObject] = [SutraObject]()
    private var showingBack = false
    
    fileprivate var index: Int
    
    public required init?(coder aDecoder: NSCoder) {
        index = 0
        super.init(coder: aDecoder)
    }
    
    public init(images: [UIImage], index: Int) {
        self.images = images
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    public init() {
        self.index = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if self.images.count == 0 {
            self.images = [#imageLiteral(resourceName: "FrontPage")]
            getObjects()
        }
        view.backgroundColor = .black
        preparePhotos()
        prepareSwipeDown()
        prepareCollectionView()
        view.becomeFirstResponder()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareNavigationBar()
        getObjects()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension PhotoViewController {
    fileprivate func preparePhotos() {
        images.forEach { [weak self, w = view.bounds.width] in
            self?.dataSourceItems.append(DataSourceItem(data: $0, width: w))
        }
    }
    
    fileprivate func getObjects() {
        guard let sutraRef = dataBaseManager?.getObjectRef(path: "pics") else {return}
        sutraRef.observe(.childAdded, with: { (snapshot) -> Void in
            let object = SutraObject(snapshot: snapshot)!
            self.allObjects.append(object)
            if let image = self.dataBaseManager?.getImageFromLocalFile(fileURL: "\(object.title).png") {
                self.images.append(image)
                self.collectionView.reloadData()
                return
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
    
    func prepareSwipeDown() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeDown.direction = .down
        swipeDown.delegate = self
        view.addGestureRecognizer(swipeDown)
    }
    
    func swipeDownAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: PhotoCollectionViewController(images: images), completion: nil)
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
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        view.layout(collectionView).center().width(view.bounds.width).height(view.height)
        
        collectionView.scrollRectToVisible(CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width, height: view.height), animated: false)
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
        
        return cell
    }
}

extension PhotoViewController: CollectionViewDelegate {
    
}
