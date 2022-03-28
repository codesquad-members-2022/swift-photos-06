//
//  StorageTest.swift
//  group6Tests
//
//  Created by Kai Kim on 2022/03/22.
//

import XCTest
@testable import group6

class StorageTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let storage = Storage()
        
        var shapes : [CustomShape] = []
        storage.addShape(shapes : shapes)
        XCTAssertEqual(storage.count, 0 , "Wrong!")
        
        
        shapes.append(contentsOf: [CustomShape(id: "dd", color: CustomColor(red: 1, green: 1, blue: 2), size: CustomSize(width: 80, height: 80))])
        storage.addShape(shapes : shapes)
        XCTAssertEqual(storage.count, 1 , "Wrong!")

        let shape = storage[0]
        
        //Complie error
        //storage[-1]
        
        //error
        let error = storage[2]
        
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
