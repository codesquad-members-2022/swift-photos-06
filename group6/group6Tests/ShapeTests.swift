//
//  group6Tests.swift
//  group6Tests
//
//  Created by Kai Kim on 2022/03/21.
//

import XCTest
@testable import group6

class ShapeTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        
    }

    func testChangeColor() throws {
        
        //Color 생성
        var r : Double = 0
        var g : Double = 19
        var b : Double = 3
        
        var colorTest1 = Color(r: r, g: g, b: b)
         
        
        //Color errors
        var colorTest2 = Color(r: -1, g: 292, b: 1) //0~255 범위 초과
        colorTest1.blue = 50 //속성값 private let 으로 설정
        colorTest1.red = 120
        colorTest1.green = 122

        
        //속성값들 은 Private let 으로 설정, 외부에서 접근 불가.
        var model = Shape(id: Id(),color: Color(r: 1, g: 2, b: 3), size: Size(width:80 , height:80))
        
        
        //변수 변경 불가.
        model.color = Color.white
        model.size = Size(80,80)
        model.id = "#32152"
    
  
    }
    
    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
