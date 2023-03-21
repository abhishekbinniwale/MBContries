//
//  CountryDetailsPresenter.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import Foundation

class CountryDetailsPresenter: ViewToPresenterCountryDetailsProtocol {
    // MARK: Properties
    weak var view: PresenterToViewCountryDetailsProtocol?
    var interactor: PresenterToInteractorCountryDetailsProtocol?
    var router: PresenterToRouterCountryDetailsProtocol?
    var provinces = [Province]()
    
    func viewDidLoad() {
        interactor?.getImageURL()
        interactor?.getProvincesForCountry()
    }
    
    func refresh() {
        interactor?.getProvincesForCountry()
    }
    
    func numberOfRowsInSection() -> Int {
        return provinces.count
    }
    
    func provinceAt(index: Int) -> Province? {
        let province = provinces[index]
        return province
    }
}

// Delegate call backs from Interactor
extension CountryDetailsPresenter: InteractorToPresenterCountryDetailsProtocol {
    
    func getImageURL(countryName: String, url: String) {
        view?.onGetImageURL(countryName, imageURL: url)
    }
    
    func getProvincesForCountrySuccess(provinces: [Province]) {
        self.provinces.append(contentsOf: provinces)
        let noProvinces = self.provinces.count > 0 ? false : true
        view?.onGetProvincesSuccess(provinceIsEmpty: noProvinces)
    }
    
    func getProvincesForCountryFailure(error: String) {
        view?.onGetProvincesFailure(error: error)
        router?.showFailureAlert(on: view!, text: "Error Alert", message: "Couldn't fetch provinces: \(error)", actionText: "Retry") { [weak self] callRetry  in
            //Call retry for API call
            guard let self = self else { return }
            if callRetry {
                self.refresh()
            }
        }
    }
}
