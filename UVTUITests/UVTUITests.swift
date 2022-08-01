//
//  UVTUITests.swift
//  UVTUITests
//
//  Created by Justin Kumpe on 7/24/22.
//

import XCTest
@testable import UVT

class UVTUITests: XCTestCase {

    let app = XCUIApplication()
    let elementsQuery = XCUIApplication().scrollViews.otherElements

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        app.launch()
        XCUIDevice.shared.orientation = .portrait
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

    func testEthernetWiring() throws {
        testImageView("RJ45 Wiring Scheme")
    }

    func testCopperColorCode() throws {
        testImageView("Copper Color Code")
    }

    func testFiberColorCode() throws {
        testImageView("Fiber Color Code")
    }

    func testStaticIP() throws {
        let module = app.collectionViews.cells.otherElements.containing(.staticText, identifier: "UV Static IP Instructions").element
        let submitButton = app/*@START_MENU_TOKEN@*/.buttons["Submit"]/*[[".scrollViews.buttons[\"Submit\"]",".buttons[\"Submit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Submit"]
        let blockSize = app/*@START_MENU_TOKEN@*/.textFields["Block Size"]/*[[".scrollViews.textFields[\"Block Size\"]",".textFields[\"Block Size\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let ipAddressField = app/*@START_MENU_TOKEN@*/.textFields["Start IP Address"]/*[[".scrollViews.textFields[\"Start IP Address\"]",".textFields[\"Start IP Address\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let aarisButton = app/*@START_MENU_TOKEN@*/.buttons["AARIS RG Instructions"]/*[[".scrollViews.buttons[\"AARIS RG Instructions\"]",".buttons[\"AARIS RG Instructions\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["AARIS RG Instructions"]
        let paceButton = app/*@START_MENU_TOKEN@*/.buttons["PACE RG Instructions"]/*[[".scrollViews.buttons[\"PACE RG Instructions\"]",".buttons[\"PACE RG Instructions\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["PACE RG Instructions"]
        let shareButton = app.navigationBars["UVT.StaticIPView"].buttons["Share"]
        module.waitTap(application: app, wait: 5, canFail: true)
        if ipAddressField.waitForExistence(timeout: 5) {
            ipAddressField.pasteTextFieldText(app: app, element: ipAddressField, value: "127.0.0.1", clearText: false)
        }
        if blockSize.waitForExistence(timeout: 5) {
            blockSize.pasteTextFieldText(app: app, element: blockSize, value: "8", clearText: false)
        }
        submitButton.waitTap(application: app, wait: 5, canFail: true)
        ipAddressField.testExists(app: app, wait: 7, sleepInterval: 7)
        if ipAddressField.waitForExistence(timeout: 5) {
            ipAddressField.pasteTextFieldText(app: app, element: ipAddressField, value: "68.1.229.1", clearText: false)
        }
        if blockSize.waitForExistence(timeout: 5) {
            blockSize.pasteTextFieldText(app: app, element: blockSize, value: "9", clearText: false)
        }
        submitButton.waitTap(application: app, wait: 5, canFail: true)
        ipAddressField.testExists(app: app, wait: 7, sleepInterval: 7)
        if blockSize.waitForExistence(timeout: 5) {
            blockSize.pasteTextFieldText(app: app, element: blockSize, value: "8", clearText: false)
        }
        submitButton.waitTap(application: app, wait: 5, canFail: true)
        aarisButton.testExists(app: app, wait: 5)
        paceButton.testExists(app: app, wait: 5)
        paceButton.waitTap(application: app, wait: 5, canFail: true)
        aarisButton.waitTap(application: app, wait: 5, canFail: true)
        shareButton.waitTap(application: app, wait: 5, canFail: true)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    func tapCoordinate(at xCoordinate: Double, and yCoordinate: Double) {
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
        coordinate.tap()
    }

    func testImageView(_ moduleName: String) {
        let module = app.collectionViews.cells.otherElements.containing(.staticText, identifier: moduleName).element
        let close = app.navigationBars["UVT.ImageView"].buttons["Back"]
        guard module.waitForExistence(timeout: 10) else {
            XCTFail("\(moduleName) Button does  not exist")
            return
        }
        module.forceTapElement()
        sleep(5)
        guard close.waitForExistence(timeout: 10) else {
            XCTFail("Back button does not exist")
            return
        }
        close.forceTapElement()
    }

}

extension XCUIElement {
    // The following is a workaround for inputting text in the
    // simulator when the keyboard is hidden
    func setText(text: String, application: XCUIApplication) {
        UIPasteboard.general.string = text
        doubleTap()
        if application.menuItems["Paste"].waitForExistence(timeout: 10) {
            application.menuItems["Paste"].tap()
        }
    }

    func waitTap(application: XCUIApplication, wait: TimeInterval, canFail: Bool) {
        if self.waitForExistence(timeout: wait) {
            self.forceTapElement()
        } else if canFail {
            XCTFail("button \(self.label) does not exist so can not be tapped")
        }
    }

    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }

    func testExists(app: XCUIApplication, wait: TimeInterval, sleepInterval: UInt32 = 0) {
        sleep(sleepInterval)
        guard self.waitForExistence(timeout: wait) else {
            XCTFail("\(self.label) does not exist")
            return
        }
    }

    func pasteTextFieldText(app: XCUIApplication, element: XCUIElement, value: String, clearText: Bool) {
        // Get the password into the pasteboard buffer
        UIPasteboard.general.string = value

        // Bring up the popup menu on the password field
        element.tap()

        if clearText {
            element.buttons["Clear text"].tap()
        }

        element.doubleTap()

        // Tap the Paste button to input the password
        if app.menuItems["Paste"].waitForExistence(timeout: 5) {
            app.menuItems["Paste"].tap()
        } else {
            element.doubleTap()
            if app.menuItems["Paste"].waitForExistence(timeout: 10) {
                app.menuItems["Paste"].tap()
            }
        }
    }

}

extension XCUIApplication {
    func setSeenTutorial(_ seenTutorial: Bool = true) {
        guard seenTutorial else {
            return
        }
        launchArguments += ["-lastBuildHome", "999999"]
        launchArguments += ["-lastBuildImages", "999999"]
        launchArguments += ["-lastBuildStaticIP", "999999"]
    }
}
