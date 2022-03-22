//
//  Storage.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/22.
//

import Foundation

final class Storage{
    private(set) var shapes: [CustomShape]?
    
    subscript(index: UInt) -> CustomShape?{
        return shapes?[Int(index)]
    }
    
    func addShape(shapes: [CustomShape]){
        if let _ = self.shapes {
            self.shapes?.append(contentsOf: shapes)
        } else{
            self.shapes = shapes
        }
    }
    
    func count() -> Int{
        guard let shapes = shapes else {
            return 0
        }
        
        return shapes.count
    }
}
