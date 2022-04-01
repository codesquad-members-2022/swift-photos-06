//
//  ViewController.swift
//  group6
//
//  Created by Kai Kim on 2022/03/21.
//

import UIKit

class CollectionViewController: UIViewController {
    private var collectionView: UICollectionView!

    private var size = CGSize(width: 100, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        
        navigationConfigure()
        collectionViewConfigure()
        collectionViewDelegate()
        CustomPhotoManager.shared.authorization {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionViewConfigure(){
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        
        self.view.addSubview(collectionView)
    }
            
    func collectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// MARK: - Use case: add Notification / Noti function

extension CollectionViewController{
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAddedCell), name: CustomPhotoManager.NotificationName.addedPhoto, object: CustomPhotoManager.shared)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDeletedCell), name: CustomPhotoManager.NotificationName.deletedPhoto, object: CustomPhotoManager.shared)
    }
    
    @objc func reloadAddedCell(notification: Notification){
        guard let addedIndexSet = notification.userInfo?[CustomPhotoManager.NotificationName.addedPhoto] as? IndexSet else{ return }
        
        let indexPath = addedIndexSet.map{ IndexPath(row: $0, section: 0) }
        
        DispatchQueue.main.async {
            self.collectionView.insertItems(at: indexPath)
        }
    }
    
    @objc func reloadDeletedCell(notification: Notification){
        guard let deletedIndexSet = notification.userInfo?[CustomPhotoManager.NotificationName.deletedPhoto] as? IndexSet else{ return }
        
        let indexPath = deletedIndexSet.map{ IndexPath(row: $0, section: 0) }
        
        DispatchQueue.main.async {
            self.collectionView.deleteItems(at: indexPath)
        }
    }
}


// MARK: - Use case: Configure CollectionView

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CustomPhotoManager.shared.fetchResultCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath)
        
        guard let photoCell = cell as? ImageCollectionCell, let asset = CustomPhotoManager.shared.getPHAsset(indexPath: indexPath) else { return UICollectionViewCell() }
        
        CustomPhotoManager.shared.requestImage(asset: asset, thumbnailSize: CustomPhotoManager.shared.thumbnailSize){ image in
            guard let image = image else { return }

            photoCell.setImage(image: image)
        }
        
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}


// MARK: - Use case: Configure NavigationBar

extension CollectionViewController{
    private func navigationConfigure(){
        navigationTitleConfigure()
        navigationBarButtonConfigure()
    }
    
    private func navigationTitleConfigure(){
        self.title = "Photos"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 21) ?? UIFont()]
    }
    
    private func navigationBarButtonConfigure(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(presentDoodleView))
    }
    
    @objc func presentDoodleView(){
        let doodleVC = DoodleViewController()
        let navController = UINavigationController(rootViewController: doodleVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
    }
}
