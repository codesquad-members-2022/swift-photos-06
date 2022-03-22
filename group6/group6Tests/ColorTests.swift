//
//  Color.swift
//  group6Tests
//
//  Created by Kai Kim on 2022/03/21.
//

import XCTest
@testable import group6

class Color: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        //Color 생성
        var r : Double = 0
        var g : Double = 19
        var b : Double = 3
        
        var colorTest1 = CustomColor(red: r, green: g, blue: b)
         
        let red = colorTest1.redValue
        let green = colorTest1.greenValue
        let blue = colorTest1.blueValue
        
        //Color errors
        var colorTest2 = CustomColor(red: -1, green: 292, blue: 1) //0~255 범위 초과
        
        //colorTest1.blue = 50 //속성값 private let 으로 설정
        //colorTest1.red = 120
        //colorTest1.green = 122
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
}
