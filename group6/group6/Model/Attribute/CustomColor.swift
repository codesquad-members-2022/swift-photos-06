//
//  Color.swift
//  group6
//
//  Created by juntaek.oh on 2022/03/22.
//

import Foundation

struct CustomColor{
    private let red: Double
    private let green: Double
    private let blue: Double
    
    var redValue: Double{
        return red / 255
    }
    
    var greenValue: Double{
        return green / 255
    }
    
    var blueValue: Double{
        return blue / 255
    }
    
    init(red: Double, green: Double, blue: Double){
        if red < 0 || red > 255{
            self.red = 255
        } else{
            self.red = red
        }
        
        if green < 0 || green > 255{
            self.green = 255
        } else{
            self.green = green
        }
        
        if blue < 0 || blue > 255{
            self.blue = 255
        } else{
            self.blue = blue
        }
    }
}
