//
//  PhotoCollectionCell.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/23.
//

import Foundation
import UIKit

class PhotoCollectionCell: UICollectionViewCell{
    static let identifier: String = "PhotoCollectionCell"
    private let imageView = UIImageView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundView = imageView
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundView = imageView
    }
    
    func setImage(image: UIImage?){
        self.imageView.image = image
    }
    
    func checkImage() -> UIImage?{
        return self.imageView.image
    }
}
