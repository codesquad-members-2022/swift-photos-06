//
//  group6Tests.swift
//  group6Tests
//
//  Created by Kai Kim on 2022/03/21.
//

import XCTest
@testable import group6

class ShapeTests: XCTestCase {

    var model : Shape!
    
    override func setUpWithError() throws {
        model = Shape(id: Id() ,color:Color(), size: Size(width : 80, height : 80))
    }

    override func tearDownWithError() throws {
    }

    func testChangeColor() throws {
        
    }
    
    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
