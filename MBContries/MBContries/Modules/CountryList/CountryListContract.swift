//
//  CountryListContract.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewCountryListProtocol: AnyObject {
    func onFetchCountryListSuccess()
    func onFetchCountryListFailure(error: String)
    
    func showHUD()
    func hideHUD()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCountryListProtocol: AnyObject {
    
    var view: PresenterToViewCountryListProtocol? { get set }
    var interactor: PresenterToInteractorCountryListProtocol? { get set }
    var router: PresenterToRouterCountryListProtocol? { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func countryAt(index: Int) -> Country?
    func didSelectcountryAt(index: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCountryListProtocol: AnyObject {
    
    var presenter: InteractorToPresenterCountryListProtocol? { get set }
    
    func loadCountryList()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCountryListProtocol: AnyObject {
    
    func fetchCountryListSuccess(countries: [Country])
    func fetchCountryListFailure(error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCountryListProtocol: AnyObject {
    
    static func createModule() -> UINavigationController
    
    func pushToCountryDetails(on view: PresenterToViewCountryListProtocol, with coutry: Country)
    func showFailureAlert(on view: PresenterToViewCountryListProtocol, text: String, message: String?, actionText: String, completion: @escaping ((_ callRetry: Bool) -> Void))
}
