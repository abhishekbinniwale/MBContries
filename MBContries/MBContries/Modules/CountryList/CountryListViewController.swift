//
//  CountryListViewController.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import UIKit
import PKHUD


class CountryListViewController: UIViewController {

    // MARK: - IBOutlet properties
    @IBOutlet weak var countryListView: UITableView!
    
    // MARK: - Properties
    private let refreshControl = UIRefreshControl()
    private let countryCellIdentifier = "countryCellIdentifier"
    
    var presenter: ViewToPresenterCountryListProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryListView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: countryCellIdentifier)
        self.pullToRefresh()
        presenter?.viewDidLoad()
        self.showHUD()
    }
    
    func pullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Load more")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        countryListView.addSubview(refreshControl)
    }
   
    
    // MARK: - Actions
    @objc func refresh(refreshControl: UIRefreshControl) {
        presenter?.refresh()
    }
    
}

// MARK: - UITableView Delegate & Data Source
extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if let country = presenter?.countryAt(index: indexPath.row) {
            cell.configureCell(county: country)
        }
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectcountryAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - Presenter To View Delegate Method

extension CountryListViewController: PresenterToViewCountryListProtocol{

    func onFetchCountryListSuccess() {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            self.hideHUD()
            self.refreshControl.endRefreshing()
            self.countryListView.reloadData()
        }
    }
    
    func onFetchCountryListFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.hideHUD()
        }
    }
    
    func showHUD() {
        DispatchQueue.main.async {
            HUD.show(.progress, onView: self.view)
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
}
