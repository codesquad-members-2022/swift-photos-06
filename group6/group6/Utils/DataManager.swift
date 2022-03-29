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
    
    private init() { }
    
    func decodeDoodle() -> [Doodle]?{
        guard let dataURL = Bundle.main.url(forResource: "doodle", withExtension: "json") else { return nil }
            
        do{
            let jsonData = try Data(contentsOf: dataURL)
            let decoder = JSONDecoder()
            let data = try decoder.decode([Doodle].self, from: jsonData)
            
            return data
        } catch{
            os_log("%@", "\(error)")
            return nil
        }
    }
}
