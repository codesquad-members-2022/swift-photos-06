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
        PHPhotoLibrary.shared().register(self)
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
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.identifier, for: indexPath)
        
        guard let photoCell = cell as? PhotoCollectionCell, let asset = fetchResult?.object(at: indexPath.item) else {return UICollectionViewCell()}
        
        CustomPhotoManager.shared.requestImage(asset: asset, thumbnailSize: CustomPhotoManager.shared.thumbnailSize){ image in
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
// MARK: - Use case: fetchPHAsset

extension ViewController {
    func fetchPHAsset(){
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            self.fetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        }
        
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorized:
                self.fetchResult = PHAsset.fetchAssets(with: nil)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            default :
                break
            }
        }
    }

}


extension ViewController : PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let asset = fetchResult , let change = changeInstance.changeDetails(for: asset) else {return}
        self.fetchResult = change.fetchResultAfterChanges
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
