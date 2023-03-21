//
//  MockProvinceService.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import Foundation

import Foundation
@testable import MBContries

class MockProvinceService {
    
    var shouldReturnError = false
    var getProvinceCalled = false

    func reset() {
        shouldReturnError = false
        getProvinceCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    
    let  mockProvinces = [ Province(ID: 253, CountryCode: "AF", Code: "BDS", Name: "Badakhshan province"),
                           Province(ID: 255, CountryCode: "AF", Code: "BDG", Name: "Badghis"),
                           Province(ID: 259, CountryCode: "AF", Code: "BGL", Name: "Baghlan"),
                           Province(ID: 271, CountryCode: "AF", Code: "BAL", Name: "Balkh province")
    ]
}

extension MockProvinceService: ProvinceServiceProtocol {
    
    func getProvinceForCountry(countryCode: Int, completion: @escaping (Result<[Province], Error>) -> ()) {
        if shouldReturnError {
            completion(.failure(CustomError.invalidUrl))
        } else {
            completion(.success(mockProvinces))
        }
    }
    
    func configureApiCall(_ configURL: String, countryCode: Int) -> String {
        if shouldReturnError {
            return "coountry"
        } else {
           return "country/" + "\(countryCode)/" + "province"
        }
    }
}
