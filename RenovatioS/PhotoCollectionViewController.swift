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
    fileprivate let dataBaseManager = DatabaseManager.shared
    var allObjects: [SutraObject] = [SutraObject]()
    private var showingBack = false
    weak var delegate: SelectedImageDelegate?
    
    public init(all: [SutraObject]) {
        self.allObjects = all
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        isMotionEnabled = true
        view.backgroundColor = .black
        prepareCollectionView()
        prepareNavigationBar()
        delegate = PhotoViewController.shared
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
    
    func prepareNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allObjects.count
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.image = allObjects[indexPath.item].image
        cell.transition(.fadeOut, .scale(0.75))
        
        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate {
    @objc
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected(object: allObjects[indexPath.item])
        if let photoVC = delegate as? PhotoViewController {
            photoVC.index = allObjects[indexPath.item].index
        }
        dismiss(animated: true, completion: {
            if let photoVC = self.delegate as? PhotoViewController {
                print(photoVC.index)
            }
        })
    }
}
