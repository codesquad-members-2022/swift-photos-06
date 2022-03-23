//
//  PhotocellTest.swift
//  group6Tests
//
//  Created by Kai Kim on 2022/03/23.
//

import XCTest
import UIKit
@testable import group6

class PhotocellTest: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    

    func testPhotoCell() throws {
        var photoCell = PhotoCollectionCell()
        let testImage = UIImage(systemName: "rectangle")
        photoCell.setImage(Image: testImage)
        XCTAssertEqual(photoCell.imageView?.image,testImage, "Wrong Image!")
        XCTAssertEqual(PhotoCollectionCell.id,"PhotoCollectionCell", "Wrong Id!")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
