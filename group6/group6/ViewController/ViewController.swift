//
//  ViewController.swift
//  group6
//
//  Created by Kai Kim on 2022/03/21.
//

import UIKit
import Photos

class ViewController: UIViewController {
    private var fetchResult : PHFetchResult<PHAsset>?
    private var collectionView: UICollectionView!

    private var size = CGSize(width: 100, height: 100)
    
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
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.fetchResult = PHAsset.fetchAssets(with: nil)
        default:
            PHPhotoLibrary.requestAuthorization(){ status in
                switch status {
                case .authorized:
                    self.fetchResult = PHAsset.fetchAssets(with: nil)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                default:
                    self.fetchResult = nil
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.identifier, for: indexPath)
        
        guard let photoCell = cell as? PhotoCollectionCell, let asset = fetchResult?.object(at: indexPath.item) else {return UICollectionViewCell()}
        
        CustomImageManager.shared.requestImage(asset: asset, thumbnailSize: CustomImageManager.shared.thumbnailSize){ image in
            photoCell.setImage(image: image)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
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
