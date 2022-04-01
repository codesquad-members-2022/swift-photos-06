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
        static let addedPhoto = Notification.Name("addedPhoto")
        static let deletedPhoto = Notification.Name("deletedPhoto")
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
    
    func getPHAsset(indexPath: IndexPath) -> PHAsset?{
        let asset = fetchResult?.object(at: indexPath.item)
        
        return asset
    }
    
    func requestImage(asset: PHAsset?, thumbnailSize: CGSize, completion: @escaping (UIImage?) -> Void){
        guard let asset = asset else {
            let noImage = UIImage(systemName: "multiply")
            completion(noImage)
            return
        }
         
        self.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFit, options: nil){ image, _ in
            completion(image)
        }
    }
    
    func authorization(completion: @escaping () -> ()){
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.fetchImage()
            self.startCachingPHAsset()
            
        default:
            PHPhotoLibrary.requestAuthorization(){ status in
                switch status {
                case .authorized:
                    self.fetchImage()
                    self.startCachingPHAsset()
                    completion()
                default:
                    break
                }
            }
        }
    }
    
    func fetchImage(){
        self.fetchResult = PHAsset.fetchAssets(with: nil)
    }
    
    func startCachingPHAsset() {
        guard let assets = self.fetchResult else {return}
        let index : IndexSet = IndexSet(integersIn: 0..<assets.count)
        let assetArray : [PHAsset] = assets.objects(at: index)
        self.startCachingImages(for: assetArray, targetSize: self.thumbnailSize, contentMode: .aspectFit,  options: nil)
    }
}


// MARK: - Use case: PHPhotoLibrary adopt

extension CustomPhotoManager: PHPhotoLibraryChangeObserver{
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let previousFetchResult = fetchResult, let change = changeInstance.changeDetails(for: previousFetchResult) else { return }
        let newFetchResult = change.fetchResultAfterChanges
        
        if previousFetchResult.count > newFetchResult.count{
            self.fetchResult = newFetchResult
            NotificationCenter.default.post(name: CustomPhotoManager.NotificationName.deletedPhoto, object: self, userInfo: [CustomPhotoManager.NotificationName.deletedPhoto : change.removedIndexes as Any])
        } else if previousFetchResult.count < newFetchResult.count{
            self.fetchResult = newFetchResult
            NotificationCenter.default.post(name: CustomPhotoManager.NotificationName.addedPhoto, object: self, userInfo: [CustomPhotoManager.NotificationName.addedPhoto : change.insertedIndexes as Any])
        }
    }
}
