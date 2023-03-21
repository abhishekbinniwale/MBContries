//
//  MockCountryListService.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import Foundation
@testable import MBContries

class MockCountryListService {
    
    var shouldReturnError = false
    var getCountriedCalled = false

    func reset() {
        shouldReturnError = false
        getCountriedCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    
    let mockGetCountries = [ Country(ID: 227, Name: "Unitaed states", Code: "US", PhoneCode: "1"),
                             Country(ID: 38, Name: "CANADA", Code: "CA", PhoneCode: "1"),
                             Country(ID: 53, Name: "CAPE VERDE", Code: "CV", PhoneCode: "238"),
                             Country(ID: 123, Name: "CAYMAN ISLANDS", Code: "KY", PhoneCode: "1345"),
               ]
}

extension MockCountryListService: CountryListServiceProtocol {
    func getCountries(count: Int, completion: @escaping (Result<[Country], Error>) -> ()) {
        getCountriedCalled = true
        
        if shouldReturnError {
            completion(.failure(CustomError.invalidUrl))
        } else {
            completion(.success(mockGetCountries))
        }
    }
    
    func configureApiCall(_ baseURL: String) -> String {
        if shouldReturnError {
            return ""
        } else {
            return baseURL
        }
    }
}
