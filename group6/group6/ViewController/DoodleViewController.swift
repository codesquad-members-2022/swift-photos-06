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
        
        navigationItemFigure()
        collectionViewConfigure()
    }
    
    func collectionViewConfigure(){
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 75, width: self.view.frame.width, height: self.view.frame.height - 75), collectionViewLayout: layout)
        self.collectionView.backgroundColor = .gray
        
        self.collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifier)
        
        self.view.addSubview(collectionView)
    }
    
    func navigationItemFigure(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: 35))
        navBar.delegate = self
        
        let navItem = UINavigationItem(title: "DoodleTitle")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dismissDoodleView))
        navItem.rightBarButtonItem = doneItem
        navItem.title = "Doodle"

        navBar.setItems([navItem], animated: false)
        
        self.view.addSubview(navBar)
        
    }
    
    @objc func dismissDoodleView(){
        self.dismiss(animated: true)
    }
    
    func decodeDoodle(){
        if let data = Bundle.main.url(forResource: "doodle", withExtension: "json"){
            do{
                let jsonData = try Data(contentsOf: data)
                let decoder = JSONDecoder()
                self.doodleDatas = try decoder.decode([Doodle].self, from: jsonData)
            } catch{
                return
            }
        }
    }
            
    /*
    func collectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
     */
}
