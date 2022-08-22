//
//  UVTTests.swift
//  UVTTests
//
//  Created by Justin Kumpe on 8/18/22.
//

import XCTest
@testable import UVT

class UVTTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCopperPairStruct() throws {
        let pair13 = CopperPair.init(pair: 13)
        let pair25 = CopperPair.init(pair: 25)
        XCTAssertEqual(pair13.tip, "black")
        XCTAssertEqual(pair13.ring, "green")
        XCTAssertEqual(pair13.tipColor, .black)
        XCTAssertEqual(pair13.ringColor, .green)
        XCTAssertEqual(pair25.tip, "violet")
        XCTAssertEqual(pair25.ring, "slate")
        XCTAssertEqual(pair25.tipColor, .purple)
        XCTAssertEqual(pair25.ringColor, .gray)
        XCTAssertNotEqual(pair25.tip, "black")
        XCTAssertNotEqual(pair25.ring, "green")
        XCTAssertNotEqual(pair25.tipColor, .black)
        XCTAssertNotEqual(pair25.ringColor, .green)
    }

}
