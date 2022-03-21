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

    func testExample() throws {

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
