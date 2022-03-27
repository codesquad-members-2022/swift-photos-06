//
//  CustomImageManager.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/24.
//

import Foundation
import UIKit
import Photos

final class CustomPhotoManager: PHCachingImageManager{
    enum NotificationName{
        static let reloadCollectionView = Notification.Name("reloadCollectionView")
        static let addedAsset = Notification.Name("addedAsset")
        static let deletedAsset = Notification.Name("deletedAsset")
    }
    
    static let shared = CustomPhotoManager()
    private var fetchResult : PHFetchResult<PHAsset>?
    
    private(set) var thumbnailSize = CGSize(width: 100, height: 100)
    
    private override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
    }
    
    func changeThumbnailSize(width: Double, height: Double){
        self.thumbnailSize = CGSize(width: width, height: height)
    }
}


// MARK: - Use case: Fetch Asset and Request Images

extension CustomPhotoManager{
    func fetchResultCount() -> Int{
        return fetchResult?.count ?? 0
    }
    
    func getImage(indexPath: IndexPath) -> PHAsset?{
        let asset = fetchResult?.object(at: indexPath.item)
        
        return asset
    }
    
    func requestImage(asset: PHAsset?, thumbnailSize: CGSize, completion: @escaping (UIImage?) -> Void){
        guard let asset = asset else {
            completion(nil)
            return
        }
         
        self.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFit, options: nil){ image, _ in
            guard let image = image else {
                let noImage = UIImage(systemName: "multiply")
                completion(noImage)
                return
            }
            
            completion(image)
        }
    }
    
    func fetchPHAsset(){
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.fetchResult = PHAsset.fetchAssets(with: nil)
            self.startCachingPHAsset()
            
        default:
            PHPhotoLibrary.requestAuthorization(){ status in
                switch status {
                case .authorized:
                    self.fetchResult = PHAsset.fetchAssets(with: nil)
                    self.startCachingPHAsset()
                    
                    DispatchQueue.main.async {
                        self.reloadCollectionView()
                    }
                default:
                    self.fetchResult = nil
                }
            }
        }
    }
    
    func startCachingPHAsset() {
        guard let assets = self.fetchResult else {return}
        let index : IndexSet = IndexSet(integersIn: 0..<assets.count)
        let assetArray : [PHAsset] = assets.objects(at: index)
        self.startCachingImages(for: assetArray, targetSize: self.thumbnailSize, contentMode: .aspectFit,  options: nil)
    }
    
    func reloadCollectionView(){
        NotificationCenter.default.post(name: CustomPhotoManager.NotificationName.reloadCollectionView, object: self, userInfo: nil)
    }
}


// MARK: - Use case: PHPhotoLibrary adopt

extension CustomPhotoManager: PHPhotoLibraryChangeObserver{
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let asset = fetchResult, let change = changeInstance.changeDetails(for: asset) else { return }
        let afterChangesAsset = change.fetchResultAfterChanges
        //self.fetchResult = change.fetchResultAfterChanges
        
        if asset.count > afterChangesAsset.count{
            self.fetchResult = afterChangesAsset
            NotificationCenter.default.post(name: CustomPhotoManager.NotificationName.deletedAsset, object: self, userInfo: [CustomPhotoManager.NotificationName.deletedAsset : change.removedIndexes as Any])
        } else if asset.count < afterChangesAsset.count{
            self.fetchResult = afterChangesAsset
            NotificationCenter.default.post(name: CustomPhotoManager.NotificationName.addedAsset, object: self, userInfo: [CustomPhotoManager.NotificationName.addedAsset : change.insertedIndexes as Any])
        }
        
        /*
        DispatchQueue.main.async {
            self.reloadCollectionView()
        }
         */
    }
}
