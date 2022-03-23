//
//  ViewController.swift
//  group6
//
//  Created by Kai Kim on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {
    private let shapeFactory = ShapeFactory()
    private var storage = Storage()
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        
        makeShapeData()
        
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
    
    func makeShapeData(){
        let shapes = shapeFactory.makeShapes(num: 40)
        self.storage.addShape(shapes: shapes)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let shape = storage[UInt(indexPath.item)] else{ return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RectangleCollectionCell.identifier, for: indexPath)
        cell.backgroundColor = UIColor(red: shape.color.redValue, green: shape.color.greenValue, blue: shape.color.blueValue, alpha: 1)
        
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
