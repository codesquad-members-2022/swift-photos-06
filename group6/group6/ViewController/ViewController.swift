//
//  ViewController.swift
//  group6
//
//  Created by Kai Kim on 2022/03/21.
//

import UIKit
import Photos

class ViewController: UIViewController {
    private let shapeFactory = ShapeFactory()
    private var storage = Storage()
    private var fetchResult : PHFetchResult<PHAsset>?
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        collectionViewConfigure()
        collectionViewDelegate()
        fetchPHAsset()
        
    }
    
    func collectionViewConfigure(){
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifier)
        
        self.view.addSubview(collectionView)
    }
            
    func collectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func fetchPHAsset(){
        let accessLevel : PHAccessLevel = .readWrite
        PHPhotoLibrary.requestAuthorization(for: accessLevel) { (status) in
            switch status {
            case .authorized :
                self.fetchResult = PHAsset.fetchAssets(with: nil)
            default :
                self.fetchResult = nil
            }
        }
    }
    

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let shape = storage[UInt(indexPath.item)] else{ return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.identifier, for: indexPath)
        
        guard let photoCell = cell as? PhotoCollectionCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let shape = storage[UInt(indexPath.item)] else{ return CGSize() }
            
        return CGSize(width: shape.size.width, height: shape.size.height)
    }
}


// MARK: - Use case: Configure NavigationBar

extension ViewController{
    private func navigationConfigure(){
        navigationTitleConfigure()
        navigationRightBarButtonConfigure()
    }
    
    private func navigationTitleConfigure(){
        self.title = "Photos"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 21) ?? UIFont()]
    }
    
    private func navigationRightBarButtonConfigure(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: nil)
    }
}
