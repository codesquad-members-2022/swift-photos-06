//
//  CustomShape.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/22.
//

import Foundation

class CustomShape{
    let id: String
    private(set) var color: CustomColor
    private(set) var size: CustomSize
    
    init(id: String ,color: CustomColor, size: CustomSize){
        self.id = id
        self.color = color
        self.size = size
    }
}
