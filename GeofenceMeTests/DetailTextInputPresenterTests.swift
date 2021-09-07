//
//  DetailTextInputPresenterTests.swift
//  GeofenceMeTests
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import XCTest
@testable import GeofenceMe

class DetailTextInputPresenterTests: XCTestCase {

    func defaultPresenter(name: String = "Sweet Level", value: String? = "Half Sugar") -> DetailTextInputPresenter {
        let presenter = DetailTextInputPresenter(label: name, value: value)
        return presenter
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLabelStringReturnsCorrectValue() throws {
        let presenter = defaultPresenter()
        XCTAssertTrue(presenter.labelString == "Sweet Level")
    }
    
    func testValueStringReturnsCorrectValue() throws {
        let presenter = defaultPresenter()
        XCTAssertTrue(presenter.valueString == "Half Sugar")
    }
    
    func testNoValueReturnsEmptyString() {
        let presenter = defaultPresenter(name: "Chicana", value: nil)
        XCTAssertTrue(presenter.valueString == "")
    }
    
    func testSavePresenterCallsPopMethodInAppCoordinator() {
        let presenter = defaultPresenter()
        let coordinatorSpy = AppCoordinatingSpy()
        presenter.coordinator = coordinatorSpy
        
        let countBefore = coordinatorSpy.popDetailCalledCount
        
        presenter.savePressed()
        
        XCTAssertTrue(coordinatorSpy.popDetailCalledCount == countBefore + 1)
    }
}
