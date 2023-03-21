//
//  APIManager.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 11/03/23.
//

import Foundation

// API Manager class to manage the API urls
class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://connect.mindbodyonline.com/rest/worldregions"
    }()
    lazy var imageURL: String = {
        return "https://raw.githubusercontent.com/hampusborgos/country-flags/main/png250px/"
    }()
}
