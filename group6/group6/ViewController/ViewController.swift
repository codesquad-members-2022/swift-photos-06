//
//  ViewController.swift
//  group6
//
//  Created by Kai Kim on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    let rectangle = CustomShape(id: "abc", color: CustomColor(red: 0, green: 0, blue: 250), size: CustomSize(width: 80, height: 80))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewConfigure()
        collectionViewDelegate()
    }
    
    func collectionViewConfigure(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView.register(RectangleCollectionCell.self, forCellWithReuseIdentifier: RectangleCollectionCell.identifier)
        
        self.view.addSubview(collectionView)
    }
            
    func collectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RectangleCollectionCell.identifier, for: indexPath)
        cell.backgroundColor = UIColor(red: rectangle.color.redValue, green: rectangle.color.greenValue, blue: rectangle.color.blueValue, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = rectangle.size.width
        let cellHeight = rectangle.size.height
            
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

