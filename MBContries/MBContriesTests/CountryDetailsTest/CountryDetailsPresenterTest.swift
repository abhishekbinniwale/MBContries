//
//  CountryDetailsPresenterTest.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import XCTest
@testable import MBContries

final class CountryDetailsPresenterTest: XCTestCase {

    var presenter: CountryDetailsPresenter!
    var view = MockCountryDetailsView()
    var interactor = MockCountryDetailsInteractor()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
          presenter = CountryDetailsPresenter()
          presenter.view = view
          presenter.interactor = interactor
          interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.presenter = nil
    }

    func testFetchProvinceListSuccess() {
        let province = Province(ID: 253, CountryCode: "AF", Code: "BDS", Name: "Badakhshan province")
        presenter.getProvincesForCountrySuccess(provinces: [province])
        if view.provinceIsEmpty {
            XCTFail("getProvincesForCountrySuccess func not called")
        }
    }
    
    func testFetchProvinceListFailure() {
        let error: String = "Couldn\'t fetch countries: \(CustomError.invalidUrl.localizedDescription)"
        presenter.getProvincesForCountryFailure(error: error)
        XCTAssertEqual(view.error, error)
    }
    
    func testGetImageUrlSuccess() {
        let url = "https://connect.mindbodyonline.com/rest/worldregions/country/227/province"
        let countryName = "Unitaed States"
            presenter.getImageURL(countryName: countryName, url: url)
        XCTAssertEqual(view.countryName, countryName)
        XCTAssertEqual(view.imageUrl, url)
    }
}
