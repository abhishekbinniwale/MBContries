//
//  CountryDetailsRouter.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import UIKit

class CountryDetailsRouter: PresenterToRouterCountryDetailsProtocol {
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static func createModule(with coutry: Country) -> UIViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "CountryDetailsViewController") as! CountryDetailsViewController
        
        let presenter: ViewToPresenterCountryDetailsProtocol & InteractorToPresenterCountryDetailsProtocol = CountryDetailsPresenter()
        let interactor = CountryDetailsInteractor()
        let router = CountryDetailsRouter()
        
        view.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        interactor.country = coutry
        interactor.presenter = presenter
        
        return view
    }
    
    // MARK:- Alerts
    // To show alerts for error
    func showFailureAlert(on view: PresenterToViewCountryDetailsProtocol, text: String, message: String?, actionText: String, completion: @escaping ((_ callRetry: Bool) -> Void)) {
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
            let viewController = view as! CountryDetailsViewController
            
            viewController.present(alertController, animated: true)
        }
        
    }
}
