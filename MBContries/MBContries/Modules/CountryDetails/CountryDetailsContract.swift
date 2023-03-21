//
//  CountryDetailsContract.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewCountryDetailsProtocol: AnyObject {
    
    func onGetImageURL(_ countryName: String, imageURL: String)
    func onGetProvincesSuccess(provinceIsEmpty: Bool)
    func onGetProvincesFailure(error: String)
    
    func showHUD()
    func hideHUD()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCountryDetailsProtocol: AnyObject {
    
    var view: PresenterToViewCountryDetailsProtocol? { get set }
    var interactor: PresenterToInteractorCountryDetailsProtocol? { get set }
    var router: PresenterToRouterCountryDetailsProtocol? { get set }

    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func provinceAt(index: Int) -> Province?

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCountryDetailsProtocol: AnyObject {

    var presenter: InteractorToPresenterCountryDetailsProtocol? { get set }
    var country: Country? { get set }
    
    func getImageURL()
    func getProvincesForCountry()
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCountryDetailsProtocol: AnyObject {
    func getImageURL(countryName: String, url: String)
    func getProvincesForCountrySuccess(provinces: [Province])
    func getProvincesForCountryFailure(error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCountryDetailsProtocol: AnyObject {
    
    static func createModule(with country: Country) -> UIViewController
    func showFailureAlert(on view: PresenterToViewCountryDetailsProtocol, text: String, message: String?, actionText: String, completion: @escaping ((_ callRetry: Bool) -> Void))
}
