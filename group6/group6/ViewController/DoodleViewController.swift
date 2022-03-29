//
//  DoodleViewController.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/29.
//

import Foundation
import UIKit

class DoodleViewController: UIViewController, UINavigationBarDelegate{
    private var collectionView: UICollectionView!
    private var doodleDatas = [Doodle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "Doodle"
        
        collectionViewConfigure()
    }
    
    func collectionViewConfigure(){
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        self.collectionView.backgroundColor = .gray
        
        self.collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifier)
        
        self.view.addSubview(collectionView)
    }
    
    @objc func dismissDoodleView(){
        self.dismiss(animated: true)
    }
            
    /*
    func collectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
     */
}
