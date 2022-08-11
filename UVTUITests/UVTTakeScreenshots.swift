//
//  UVTTakeScreenshots.swift
//  UVTTakeScreenshots
//
//  Created by Justin Kumpe on 7/24/22.
//

import XCTest

class UVTTakeScreenshots: XCTestCase {

    let app = XCUIApplication()
    let elementsQuery = XCUIApplication().scrollViews.otherElements

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        setupSnapshot(app)
        app.launch()
        continueAfterFailure = false
        let continueButton = XCUIApplication().buttons["Continue"]
        if continueButton.waitForExistence(timeout: 5) {
            continueButton.forceTapElement()
        }
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScreenshots() throws {
        let moduleStaticIP = app.collectionViews.cells.otherElements.containing(.staticText, identifier: "UV Static IP Instructions").element
        let submitButton = app/*@START_MENU_TOKEN@*/.buttons["Submit"]/*[[".scrollViews.buttons[\"Submit\"]",".buttons[\"Submit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Submit"]
        let blockSize = app/*@START_MENU_TOKEN@*/.textFields["Block Size"]/*[[".scrollViews.textFields[\"Block Size\"]",".textFields[\"Block Size\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let ipAddressField = app/*@START_MENU_TOKEN@*/.textFields["Start IP Address"]/*[[".scrollViews.textFields[\"Start IP Address\"]",".textFields[\"Start IP Address\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let paceButton = app/*@START_MENU_TOKEN@*/.buttons["PACE RG Instructions"]/*[[".scrollViews.buttons[\"PACE RG Instructions\"]",".buttons[\"PACE RG Instructions\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["PACE RG Instructions"]
        let shareButton = app.navigationBars["UVT.StaticIPView"].buttons["Share"]
        testImageView("RJ45 Wiring Scheme")
        testImageView("Copper Color Code")
        testImageView("Fiber Color Code")
        moduleStaticIP.waitTap(application: app, wait: 5, canFail: true)
        if ipAddressField.waitForExistence(timeout: 5) {
            ipAddressField.pasteTextFieldText(app: app, element: ipAddressField, value: "68.1.229.1", clearText: false)
        }
        if blockSize.waitForExistence(timeout: 5) {
            blockSize.pasteTextFieldText(app: app, element: blockSize, value: "8", clearText: false)
        }
        sleep(5)
        snapshot("StaticIP_Main")
        submitButton.waitTap(application: app, wait: 5, canFail: true)
        snapshot("StaticIP_Info")
        paceButton.waitTap(application: app, wait: 5, canFail: true)
        snapshot("StaticIP_PACE")
        shareButton.waitTap(application: app, wait: 5, canFail: true)
        snapshot("StaticIP_Share")
    }

    func tapCoordinate(at xCoordinate: Double, and yCoordinate: Double) {
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
        coordinate.tap()
    }

    func testImageView(_ moduleName: String) {
        let imageName = moduleName.replacingOccurrences(of: " ", with: "_")
        let module = app.collectionViews.cells.otherElements.containing(.staticText, identifier: moduleName).element
        let close = app.navigationBars["UVT.ImageView"].buttons["Back"]
        guard module.waitForExistence(timeout: 10) else {
            XCTFail("\(moduleName) Button does  not exist")
            return
        }
        module.forceTapElement()
        sleep(5)
        snapshot(imageName)
        guard close.waitForExistence(timeout: 10) else {
            XCTFail("Back button does not exist")
            return
        }
        close.forceTapElement()
    }

}
