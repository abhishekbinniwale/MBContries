//
//  CountryListServiceTest.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import XCTest
@testable import MBContries

final class CountryListServiceTest: XCTestCase {
    
    let countryListService = MockCountryListService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        countryListService.reset()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCountriesSuccess() {
        let expectation = self.expectation(description: "Get countries list expectation")
        
        countryListService.shouldReturnError = false
        countryListService.getCountries(count: 0) { result in
            switch result {
            case .success(let countries):
                XCTAssertNotNil(countries)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testGetCountriesFailure() {
        let expectation = self.expectation(description: "Get countries list expectation")
        
        countryListService.shouldReturnError = true
        countryListService.getCountries(count: 0) { result in
            switch result {
            case .success(let countries):
                XCTAssertEqual(countries.count, 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testconfigureApiCallSuccess() {
        countryListService.shouldReturnError = false
       let apiString = countryListService.configureApiCall("country")
        XCTAssertEqual(apiString, "country")
        
    }
    
    func testconfigureApiCallFailure() {
        countryListService.shouldReturnError = true
       let apiString = countryListService.configureApiCall("country")
        XCTAssertNotEqual(apiString, "country")
    }
}
