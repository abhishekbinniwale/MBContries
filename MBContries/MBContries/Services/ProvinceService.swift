//
//  ProvinceService.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 11/03/23.
//

import Foundation

protocol ProvinceServiceProtocol {
    func getProvinceForCountry(countryCode: Int, completion: @escaping (Result<[Province], Error>) -> ())
    func configureApiCall(_ configURL: String, countryCode: Int) -> String
}

// API service class for province list

class ProvinceService: ProvinceServiceProtocol {
    
    static let shared = { ProvinceService() }()
    
    // TO get the province of country by country code
    func getProvinceForCountry(countryCode: Int, completion: @escaping (Result<[Province], Error>) -> ()) {
        
        let urlString = self.configureApiCall(Endpoints.provience, countryCode: countryCode)
        
        APIClient.shared.getArray(urlString: urlString, expecting: [Province].self) { result in
            switch result {
            case .success(let provinces):
                completion(.success(provinces))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Here we can do the API configuration if wants to implement pagination.
    func configureApiCall(_ configURL: String, countryCode: Int) -> String {
        return "country/" + "\(countryCode)/" + configURL
    }
}
