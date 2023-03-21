//
//  MockCountryDetailsClasses.swift
//  MBContriesTests
//
//  Created by Abhishek Binniwale on 12/03/23.
//

import Foundation
@testable import MBContries

class MockCountryDetailsInteractor: PresenterToInteractorCountryDetailsProtocol {
    var country: Country?
    
    var presenter: InteractorToPresenterCountryDetailsProtocol?
    var isSuccessCase = false
    
    func getImageURL() {
        let url = "https://connect.mindbodyonline.com/rest/worldregions/country/227/province"
        presenter?.getImageURL(countryName: "Unitaed States", url: url)
    }
    
    func getProvincesForCountry() {
        let  provinces = [ Province(ID: 253, CountryCode: "AF", Code: "BDS", Name: "Badakhshan province"),
                           Province(ID: 255, CountryCode: "AF", Code: "BDG", Name: "Badghis"),
                           Province(ID: 259, CountryCode: "AF", Code: "BGL", Name: "Baghlan"),
                           Province(ID: 271, CountryCode: "AF", Code: "BAL", Name: "Balkh province")
             ]
        if isSuccessCase {
            presenter?.getProvincesForCountrySuccess(provinces: provinces)
        } else {
            presenter?.getProvincesForCountryFailure(error: CustomError.invalidUrl.localizedDescription)
        }
    }
}

class MockCountryDetailsView: PresenterToViewCountryDetailsProtocol {
    
    var imageUrl: String?
    var countryName: String?
    func onGetImageURL(_ countryName: String, imageURL: String) {
        self.imageUrl = imageURL
        self.countryName = countryName
    }
    
    var provinceIsEmpty = false
    func onGetProvincesSuccess(provinceIsEmpty: Bool) {
        self.provinceIsEmpty = provinceIsEmpty
    }
    
    var error : String?
    func onGetProvincesFailure(error: String) {
        self.error = error
    }
    
    func showHUD() {
        
    }
    
    func hideHUD() {
        
    }
}

class MockCountryDetailsPresenter: InteractorToPresenterCountryDetailsProtocol {
 
    var countryName: String?
    var imageUrl: String?
    func getImageURL(countryName: String, url: String) {
        self.countryName = countryName
        self.imageUrl = url
    }
    
    var provinces : [Province]?
    func getProvincesForCountrySuccess(provinces: [Province]) {
        self.provinces = provinces
    }
    
    var error: String?
    func getProvincesForCountryFailure(error: String) {
        self.error = error
    }
}

