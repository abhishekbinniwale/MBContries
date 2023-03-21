//
//  CountryListPresenter.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import Foundation

class CountryListPresenter: ViewToPresenterCountryListProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewCountryListProtocol?
    var interactor: PresenterToInteractorCountryListProtocol?
    var router: PresenterToRouterCountryListProtocol?
    var countries = [Country]()
    
    func viewDidLoad() {
        self.fetchCountryList()
    }
    
    func refresh() {
        self.fetchCountryList()
    }
    
    func fetchCountryList() {
        interactor?.loadCountryList()
    }
    
    func numberOfRowsInSection() -> Int {
        return countries.count
    }
    
    func didSelectcountryAt(index: Int) {
         let country = self.countries[index]
            self.router?.pushToCountryDetails(on: view!, with: country)
    }
    
    func countryAt(index: Int) -> Country? {
        return self.countries[index]
    }
    
}

// MARK: - Outputs to view
extension CountryListPresenter: InteractorToPresenterCountryListProtocol {
    
    func fetchCountryListSuccess(countries: [Country]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.countries.append(contentsOf: countries)
        view?.onFetchCountryListSuccess()
    }
    
    func fetchCountryListFailure(error: String) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.hideHUD()
        view?.onFetchCountryListFailure(error: "Couldn't fetch countries: \(error)")
        
        router?.showFailureAlert(on: view!, text: "Error Alert", message: "Couldn't fetch countries: \(error)", actionText: "Retry") { [weak self] callRetry  in
            //Retry for API call
            guard let self = self else { return }
            if callRetry {
                self.refresh()
            }
        }
    }
    
}
