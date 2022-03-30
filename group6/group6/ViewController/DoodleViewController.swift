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
    
    private var size = CGSize(width: 110, height: 50)
    private var collectionViewYPoint: CGFloat{
        guard let pointY = self.navigationController?.navigationBar.frame.maxY else{
            return 0
        }
        return pointY
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        DataManager.shared.decodeDoodle()
        
        navigationConfigure()
        collectionViewConfigure()
        collectionViewDelegate()
    }
    
    func collectionViewConfigure(){
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewYPoint, width: self.view.frame.width, height: self.view.frame.height - collectionViewYPoint), collectionViewLayout: layout)
        self.collectionView.backgroundColor = .gray
        
        self.collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifier)
        
        self.view.addSubview(collectionView)
    }
            
    func collectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// MARK: - Use case: Configure NavigationBar

extension DoodleViewController{
    private func navigationConfigure(){
        navigationTitleConfigure()
        navigationBarButtonConfigure()
    }
    
    private func navigationTitleConfigure(){
        self.title = "Doodle"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 21) ?? UIFont()]
    }
    
    private func navigationBarButtonConfigure(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissDoodleView))
    }
    
    @objc func dismissDoodleView(){
        self.dismiss(animated: true)
    }
}

// MARK: - Use case: Configure CollectionView

extension DoodleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.fetchResultCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.identifier, for: indexPath)
        
        guard let photoCell = cell as? PhotoCollectionCell, let doodle = DataManager.shared.getDoodle(indexPath: indexPath) else { return UICollectionViewCell() }
        
        DataManager.shared.requestImage(doodle: doodle){ image in
            guard let image = image else { return }

            DispatchQueue.main.async {
                photoCell.setImage(image: image)
            }
        }
        
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
