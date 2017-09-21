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
    static let shared: PhotoViewController! = PhotoViewController()
    var collectionView: CollectionView!
    fileprivate let dataBaseManager = DatabaseManager.shared
    var dataSourceItems = [DataSourceItem]()
    var allObjects: [SutraObject] = [SutraObject]()
    private var showingBack = false
    
    var index: Int
    
    internal required init?(coder aDecoder: NSCoder) {
        index = 0
        super.init(coder: aDecoder)
    }

    internal init() {
        self.index = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        view.backgroundColor = .black
        prepareSwipeDown()
        NotificationCenter.default.addObserver(self, selector: #selector(getObjects), name: Notification.Name("newImages"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newSelectionAction), name: Notification.Name("newSelection"), object: nil)
        view.becomeFirstResponder()
        getObjects()
        collectionView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func newSelectionAction() {
        collectionView.scrollRectToVisible(CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width, height: view.height), animated: false)
        collectionView.reloadData()
    }
}

extension PhotoViewController: SelectedImageDelegate {
    func selected(object: SutraObject) {
        print(object)
        index = object.index
        NotificationCenter.default.post(name: Notification.Name("newSelection"), object: nil)
    }
}

extension PhotoViewController {
    
    func getObjects() {
        allObjects = (dataBaseManager?.getAllObject())!
        self.dataSourceItems = allObjects.flatMap {DataSourceItem(data: $0.image, width: self.view.width)}
        collectionView.reloadData()
    }
    
    func prepareSwipeDown() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeDown.direction = .down
        swipeDown.delegate = self
        view.addGestureRecognizer(swipeDown)
    }
    
    func swipeDownAction() {
        present(PhotoCollectionViewController(all: allObjects), animated: true, completion: nil)
//        (navigationDrawerController?.rootViewController as? ToolbarController)?.navigationController?.pushViewController(PhotoCollectionViewController(all: allObjects), animated: true)
//            .transition(to: PhotoCollectionViewController(all: allObjects), completion: nil)
    }
    
    fileprivate func prepareCollectionView() {
        collectionView = CollectionView()
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        view.layout(collectionView).center().width(view.bounds.width).height(view.height)
        
        collectionView.scrollRectToVisible(CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width, height: view.height), animated: false)
    }
}

extension PhotoViewController: CollectionViewDataSource {
    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceItems.count == 0 ? 1 : dataSourceItems.count
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        if indexPath.item == 0 {
            cell.imageView.image = #imageLiteral(resourceName: "aFrontPage")
            return cell
        }
        guard let image = dataSourceItems[indexPath.item].data as? UIImage else {
            return cell
        }
        cell.imageView.image = image
        return cell
    }
}

extension PhotoViewController: CollectionViewDelegate {
    
}

