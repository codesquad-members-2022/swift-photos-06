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
        var model = CustomShape(id: "ABCD", color: CustomColor(red: 100, green: 100, blue: 100), size: CustomSize(width: 50, height: 50))
        
        let id = model.id
        let color = model.showColor()
        let size = model.showSize()
        
        //변수 변경 불가.
        //model.color = CustomColor(red: 50, green: 50, blue: 50)
        //model.size = CustomSize(width: 80, height: 80)
        //model.id = UUID()
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
