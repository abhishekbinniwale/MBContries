//
//  CountryDetailsInteractor.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import Foundation
import UIKit

class CountryDetailsInteractor: PresenterToInteractorCountryDetailsProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterCountryDetailsProtocol?
    var country: Country?
    
    func getImageURL() {
         let url = APIManager.shared.imageURL + "\(country?.Code?.lowercased() ?? "us").png"
        self.presenter?.getImageURL(countryName: country?.Name ?? "", url: url)
    }
    
    func getProvincesForCountry() {
        guard let country = country else {
            self.presenter?.getProvincesForCountryFailure(error: CustomError.invalidUrl.localizedDescription)
            return
        }
        ProvinceService.shared.getProvinceForCountry(countryCode: country.ID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let provinces):
                self.presenter?.getProvincesForCountrySuccess(provinces: provinces)
            case .failure(let error):
                self.presenter?.getProvincesForCountryFailure(error: error.localizedDescription)
            }
        }
    }
}
