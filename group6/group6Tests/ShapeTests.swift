//
//  group6Tests.swift
//  group6Tests
//
//  Created by Kai Kim on 2022/03/21.
//

import XCTest
@testable import group6

class group6Tests: XCTestCase {
    
    var color : Color!
    var model : Shape!
    var modelFactory : ModelProducible!
    var propertyFactory : PropertyProducible!
    
    override func setUpWithError() throws {
        color = Color(r: 0, g: 2, b: 3)
        modelFactory = ModelProducible(min:Point, max:Point, size:Size)
        model = Shape()
        
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
