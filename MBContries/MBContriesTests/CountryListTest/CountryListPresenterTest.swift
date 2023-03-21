//
//  CountryListInteractorTest.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import XCTest
@testable import MBContries

final class CountryListPresenterTest: XCTestCase {

    var presenter: CountryListPresenter!
    var view = MockCountryListView()
    var interactor = MockCountryListInteractor()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
          presenter = CountryListPresenter()
          presenter.view = view
          presenter.interactor = interactor
          interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.presenter = nil
    }

    // TO test fetch of country list succeess
    func testFetchCountryListSuccess() {
        let country = Country(ID: 227, Name: "Unitaed states", Code: "US", PhoneCode: "1")
        presenter.fetchCountryListSuccess(countries: [country])
        if !view.isFetchCountryListSuccess {
            XCTFail("onFetchCountryListSuccess func not called")
        }
    }
    // TO test fetch of country list failure
    func testFetchCountryListFailure() {
        let error: String = "Couldn\'t fetch countries: \(CustomError.invalidUrl.localizedDescription)"
        presenter.fetchCountryListFailure(error: CustomError.invalidUrl.localizedDescription)
        XCTAssertEqual(view.error, error)
    }

    // TO test fetch of country properties
    func testLoadCountryListSuccess() {
        interactor.isSuccessCase = true
        interactor.loadCountryList()
        let country = Country(ID: 227, Name: "Unitaed states", Code: "US", PhoneCode: "1")
        let countries = presenter.countries
        XCTAssertNotNil(countries)
        XCTAssertEqual(country.ID, countries.first?.ID)
        XCTAssertEqual(country.Name, countries.first?.Name)
        XCTAssertEqual(country.Code, countries.first?.Code)
        XCTAssertEqual(country.PhoneCode, countries.first?.PhoneCode)
    }
    
    func testLoadCountryListFailure() {
        interactor.isSuccessCase = false
        interactor.loadCountryList()
        let countries = presenter.countries
        XCTAssertTrue(countries.isEmpty)
    }
    
    func testRetrieveCountry() {
        interactor.isSuccessCase = true
        interactor.retrieveCountry(at: 0)
        let country = Country(ID: 227, Name: "Unitaed states", Code: "US", PhoneCode: "1")
        XCTAssertEqual(interactor.country?.ID, country.ID)
    }
    
}
