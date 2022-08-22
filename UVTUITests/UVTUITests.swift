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

    func testCopperPairStruct() throws {
        let pair = CopperPairModel.init(pair: 13)
        XCTAssertEqual(pair.tip, "black")
        XCTAssertEqual(pair.ring, "green")
        XCTAssertEqual(pair.tipColor, .black)
        XCTAssertEqual(pair.ringColor, .green)
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
        ipAddressField.testExists(app: app, wait: 7, sleepInterval: 9)
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

struct CopperPairModel {
    let pair: Int!
    let basePair: Int!
    let binder: Int!
    let superBinder: Int!
    let tip: String!
    let ring: String!
    var tipColor: UIColor {
        switch tip {
        case "white":
            return .white
        case "red":
            return .red
        case "black":
            return .black
        case "yellow":
            return .yellow
        case "violet":
            return .purple
        default:
            return .clear
        }
    }
    var ringColor: UIColor {
        switch ring {
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "green":
            return .green
        case "brown":
            return .brown
        case "slate":
            return .gray
        default:
            return .clear
        }
    }
    init(pair: Int) {
        self.pair = pair
        var superBinder: Int {
            switch pair {
            case 1...625:
                return 1
            case 626...1250:
                return 2
            case 1251...1875:
                return 3
            case 1876...2500:
                return 4
            case 2501...3125:
                return 5
            case 3126...3750:
                return 6
            case 3751...4375:
                return 7
            case 4376...5000:
                return 8
            case 5001...5625:
                return 9
            case 5626...6250:
                return 10
            case 6251...6875:
                return 11
            case 6876...7500:
                return 12
            case 7501...8125:
                return 13
            case 8126...8750:
                return 14
            case 8751...9375:
                return 15
            case 9376...10000:
                return 16
            case 10001...10625:
                return 17
            case 10626...11250:
                return 18
            case 112551...11875:
                return 19
            case 11876...12500:
                return 20
            case 12501...13125:
                return 21
            case 13126...13750:
                return 22
            case 13751...14375:
                return 23
            case 14376...15000:
                return 24
            case 15001...15625:
                return 25
            default:
                return 0
            }
        }
        self.superBinder = superBinder
        let superBinderSub = (superBinder - 1) * 625
        let baseBinderPair = pair - superBinderSub

        var binder: Int {
            switch baseBinderPair {
            case 1...25:
                return 1
            case 26...50:
                return 2
            case 51...75:
                return 3
            case 76...100:
                return 4
            case 101...125:
                return 5
            case 126...150:
                return 6
            case 151...175:
                return 7
            case 176...200:
                return 8
            case 201...225:
                return 9
            case 226...250:
                return 10
            case 251...275:
                return 11
            case 276...300:
                return 12
            case 301...325:
                return 13
            case 326...350:
                return 14
            case 351...375:
                return 15
            case 376...400:
                return 16
            case 401...425:
                return 17
            case 426...450:
                return 18
            case 451...475:
                return 19
            case 476...500:
                return 20
            case 501...525:
                return 21
            case 526...550:
                return 22
            case 551...575:
                return 23
            case 576...600:
                return 24
            case 601...625:
                return 25
            default:
                return 0
            }
        }
        self.binder = binder
        let binderSub = (binder - 1) * 25
        let basePair = baseBinderPair - binderSub
        self.basePair = basePair
        var tip: String {
            switch basePair {
            case 1...5:
                return "white"
            case 6...10:
                return "red"
            case 11...15:
                return "black"
            case 16...20:
                return "yellow"
            case 21...25:
                return "violet"
            default:
                return "unknown"
            }
        }
        self.tip = tip
        var ring: String {
            switch basePair {
            case 1,6,11,16,21:
                return "blue"
            case 2,7,12,17,22:
                return "orange"
            case 3,8,13,18,23:
                return "green"
            case 4,9,14,19,24:
                return "brown"
            case 5,10,15,20,25:
                return "slate"
            default:
                return "unknown"
            }
        }
        self.ring = ring
    }
}
