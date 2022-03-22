//
//  ShapeFactoryTest.swift
//  group6Tests
//
//  Created by juntaek.oh on 2022/03/22.
//

import XCTest
@testable import group6

class ShapeFactoryTest: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let factory = ShapeFactory()
        
        let shapesOne = factory.makeShapes(num: 1, width: 100, height: 70)
        let shapesTwo = factory.makeShapes(num: 30)
        
        // private 오류 발생 확인
        //let id = factory.makeID
        //let size: CustomSize = factory.makeSize(width: 80, height: 80)
        //let color: CustomColor = factory.makeColor()
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
