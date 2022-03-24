//
//  CustomImageManager.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/24.
//

import Foundation
import UIKit
import Photos

final class CustomImageManager{
    static let shared = CustomImageManager()
    fileprivate let imageManager = PHCachingImageManager()
    private var assetIdentifier: String?
    private(set) var thumbnailSize = CGSize(width: 100, height: 100)
    
    
    
    
    func requestImage(asset: PHAsset?, thumbnailSize: CGSize, completion: @escaping (UIImage?) -> Void){
        guard let asset = asset else {
            completion(nil)
            return
        }
        
        self.assetIdentifier = asset.localIdentifier
        self.imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFit, options: nil){ image, _ in
            guard let image = image else {
                let noImage = UIImage(systemName: "multiply")
                completion(noImage)
                return
            }
            
            completion(image)
        }
    }
    
    func changeThumbnailSize(width: Double, height: Double){
        self.thumbnailSize = CGSize(width: width, height: height)
    }
}
