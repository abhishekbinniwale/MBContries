//
//  CountryListService.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import Foundation

protocol CountryListServiceProtocol {
    func getCountries(count: Int, completion: @escaping (Result<[Country], Error>) -> ())
    func configureApiCall(_ baseURL: String) -> String
}

// API service class for country list

class CountryListService: CountryListServiceProtocol {
    
    static let shared = { CountryListService() }()

    
    // TO get the country list
    func getCountries(count: Int, completion: @escaping (Result<[Country], Error>) -> ()) {
        
        let urlString = self.configureApiCall(Endpoints.countries)
        
        APIClient.shared.getArray(urlString: urlString, expecting: [Country].self) { result in
            switch result {
            case .success(let countries):
                completion(.success(countries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Here we can do the API configuration if wants to implement pagination.
    func configureApiCall(_ baseURL: String) -> String {
        return baseURL
    }
}
