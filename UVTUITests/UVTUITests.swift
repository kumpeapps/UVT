//
//  UVTUITests.swift
//  UVTUITests
//
//  Created by Justin Kumpe on 7/24/22.
//

import XCTest

class UVTUITests: XCTestCase {

    let app = XCUIApplication()
    let elementsQuery = XCUIApplication().scrollViews.otherElements

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEthernetWiring() throws {
        app.launch()
        testImageView("RJ45 Wiring Scheme")
    }

    func testCopperColorCode() throws {
        app.launch()
        testImageView("Copper Color Code")
    }

    func testFiberColorCode() throws {
        app.launch()
        testImageView("Fiber Color Code")
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
        let close = app/*@START_MENU_TOKEN@*/.staticTexts["Close"]/*[[".buttons[\"Close\"].staticTexts[\"Close\"]",".staticTexts[\"Close\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        guard module.waitForExistence(timeout: 10) else {
            XCTFail("\(moduleName) Button does  not exist")
            return
        }
        module.forceTapElement()
        sleep(5)
        guard close.waitForExistence(timeout: 10) else {
            XCTFail("Close button does not exist")
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

    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
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
