//
//  ProvinceServiceTest.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import XCTest

final class ProvinceServiceTest: XCTestCase {

    let provinceService = MockProvinceService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provinceService.reset()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCountriesSuccess() {
        let expectation = self.expectation(description: "Get countries list expectation")
        
        provinceService.shouldReturnError = false
        provinceService.getProvinceForCountry(countryCode: 227) { result in
            switch result {
            case .success(let provinces):
                XCTAssertNotNil(provinces)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testGetCountriesFailure() {
        let expectation = self.expectation(description: "Get countries list expectation")
        
        provinceService.shouldReturnError = true
        provinceService.getProvinceForCountry(countryCode: 227) { result in
            switch result {
            case .success(let provinces):
                XCTAssertEqual(provinces.count, 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testconfigureApiCallSuccess() {
        provinceService.shouldReturnError = false
        let apiString = provinceService.configureApiCall("country", countryCode: 227)
        let testString = "country/227/province"
        XCTAssertEqual(apiString, testString)
        
    }
    
    func testconfigureApiCallFailure() {
        provinceService.shouldReturnError = true
        let apiString = provinceService.configureApiCall("country", countryCode: 227)
        let testString = "country/227/province"
        XCTAssertNotEqual(apiString, testString)
    }

}
