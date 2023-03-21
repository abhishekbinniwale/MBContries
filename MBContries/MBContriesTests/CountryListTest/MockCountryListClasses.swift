//
//  MockCountryListClasses.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import Foundation
@testable import MBContries

class MockCountryListInteractor: PresenterToInteractorCountryListProtocol {
    var presenter: InteractorToPresenterCountryListProtocol?
    var isSuccessCase = false
    func loadCountryList() {
        
        let  countries = [ Country(ID: 227, Name: "Unitaed states", Code: "US", PhoneCode: "1"),
                           Country(ID: 38, Name: "CANADA", Code: "CA", PhoneCode: "1"),
                           Country(ID: 53, Name: "CAPE VERDE", Code: "CV", PhoneCode: "238"),
                           Country(ID: 123, Name: "CAYMAN ISLANDS", Code: "KY", PhoneCode: "1345"),
             ]
        if isSuccessCase {
            presenter?.fetchCountryListSuccess(countries: countries)
        } else {
            presenter?.fetchCountryListFailure(error: CustomError.invalidUrl.localizedDescription)
        }
    }
    
    var country: Country?
    func retrieveCountry(at index: Int) {
        let  countries = [ Country(ID: 227, Name: "Unitaed states", Code: "US", PhoneCode: "1"),
                           Country(ID: 38, Name: "CANADA", Code: "CA", PhoneCode: "1"),
                           Country(ID: 53, Name: "CAPE VERDE", Code: "CV", PhoneCode: "238"),
                           Country(ID: 123, Name: "CAYMAN ISLANDS", Code: "KY", PhoneCode: "1345"),
             ]
        if isSuccessCase {
            country = countries[index]
        } else {
            country = nil
        }
        
    }
}

class MockCountryListView: PresenterToViewCountryListProtocol {
    var isFetchCountryListSuccess = false

    func onFetchCountryListSuccess() {
        isFetchCountryListSuccess = true
    }
    
    var error : String?
    func onFetchCountryListFailure(error: String) {
        self.error = error
    }
    
    func showHUD() {
        
    }
    
    func hideHUD() {
        
    }
}

class MockCountryListPresenter: InteractorToPresenterCountryListProtocol {
    var error: String?
    
    func fetchCountryListFailure(error: String) {
        self.error = error
    }
    
    var countries: [Country]?
    
    func fetchCountryListSuccess(countries: [Country]) {
        self.countries = countries
    }
    
}
