//
//  Color.swift
//  group6Tests
//
//  Created by Kai Kim on 2022/03/21.
//

import XCTest

class Color: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
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
    }

}
