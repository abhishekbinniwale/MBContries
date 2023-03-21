//
//  CountryListInteractor.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import Foundation

class CountryListInteractor: PresenterToInteractorCountryListProtocol {
    
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterCountryListProtocol?
    
    
    func loadCountryList() {
        CountryListService.shared.getCountries(count: 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let countries):
                self.presenter?.fetchCountryListSuccess(countries: countries)
            case .failure(let error):
                self.presenter?.fetchCountryListFailure(error: error.localizedDescription)
            }
        }
    }

}
