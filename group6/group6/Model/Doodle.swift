//
//  Doodle.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/29.
//

import Foundation

struct Doodle: Codable, CustomStringConvertible{
    var description: String{
        return "Title: \(self.title), URL: \(self.image), Date: \(self.date)"
    }
    
    let title: String
    let image: URL
    let date: String
}
