//
//  CountryListRouter.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import UIKit

class CountryListRouter: PresenterToRouterCountryListProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("CountryListRouter creates the CountryList module.")
        let view = mainstoryboard.instantiateViewController(withIdentifier: "CountryListViewController") as! CountryListViewController
        let navigationController = UINavigationController(rootViewController: view)
        
        let presenter: ViewToPresenterCountryListProtocol & InteractorToPresenterCountryListProtocol = CountryListPresenter()
        let interactor = CountryListInteractor()
        let router =  CountryListRouter()
        
        view.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navigationController
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    // MARK: - Navigation
    func pushToCountryDetails(on view: PresenterToViewCountryListProtocol, with coutry: Country) {
        let countryDetailsViewController = CountryDetailsRouter.createModule(with: coutry)
        let viewController = view as! CountryListViewController
        viewController.navigationController?
            .pushViewController(countryDetailsViewController, animated: true)
        
    }
    
    // MARK:- Alerts
    // To show alerts for error
    func showFailureAlert(on view: PresenterToViewCountryListProtocol, text: String, message: String?, actionText: String, completion: @escaping ((_ callRetry: Bool) -> Void)) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: text, message: message, preferredStyle: .alert)
            let retryAction = UIAlertAction(title: actionText, style: .default) { action in
                completion(true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                completion(false)
            }

            alertController.addAction(retryAction)
            alertController.addAction(cancelAction)
            
            let viewController = view as! CountryListViewController
            viewController.present(alertController, animated: true)
        }
    }
}
