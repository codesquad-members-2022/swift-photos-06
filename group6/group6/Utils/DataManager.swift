//
//  DataManager.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/29.
//

import Foundation
import UIKit
import os

class DataManager{
    static let shared = DataManager()
    
    private var doodles: [Doodle]?
    
    private init() { }
    
    func decodeDoodleData(){
        guard let dataURL = Bundle.main.url(forResource: "doodle", withExtension: "json") else { return }
            
        do{
            let data = try Data(contentsOf: dataURL)
            let decoder = JSONDecoder()
            let doodles = try decoder.decode([Doodle].self, from: data)
            
            self.doodles = doodles
        } catch{
            os_log("%@", "\(error)")
            return
        }
    }
    
    func modelsCount() -> Int{
        return doodles?.count ?? 0
    }
    
    func getDoodle(indexPath: IndexPath) -> Doodle?{
        let doodle = doodles?[indexPath.item]
        
        return doodle
    }
    
    func downloadImage(doodle: Doodle?, completion: @escaping (UIImage?) -> Void){
        guard let doodle = doodle else {
            let noImage = UIImage(systemName: "multiply")
            completion(noImage)
            return
        }
        
        var request = URLRequest(url: doodle.image)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let data = data, error == nil, let image = UIImage(data: data) else {
                print("Download image fail : \(doodle.image)")
                return
            }
            
            completion(image)
                  
        }.resume()
    }
}
