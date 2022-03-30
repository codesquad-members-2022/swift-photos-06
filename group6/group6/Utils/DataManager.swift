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
    
    private var fetchResult: [Doodle]?
    
    private init() { }
    
    func decodeDoodle(){
        guard let dataURL = Bundle.main.url(forResource: "doodle", withExtension: "json") else { return }
            
        do{
            let jsonData = try Data(contentsOf: dataURL)
            let decoder = JSONDecoder()
            let data = try decoder.decode([Doodle].self, from: jsonData)
            
            self.fetchResult = data
        } catch{
            os_log("%@", "\(error)")
            return
        }
    }
    
    func fetchResultCount() -> Int{
        return fetchResult?.count ?? 0
    }
    
    func getDoodle(indexPath: IndexPath) -> Doodle?{
        let doodle = fetchResult?[indexPath.item]
        
        return doodle
    }
    
    func requestImage(doodle: Doodle?, completion: @escaping (UIImage?) -> Void){
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
