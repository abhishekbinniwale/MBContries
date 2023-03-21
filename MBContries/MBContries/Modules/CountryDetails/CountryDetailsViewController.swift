//
//  CountryDetailsViewController.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import UIKit
import PKHUD

class CountryDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet properties
    @IBOutlet private weak var provinceListView: UITableView!
    @IBOutlet private weak var countryImageView: UIImageView!
    @IBOutlet weak var emptyView: UIView!
    

    // MARK: - Properties
    private let refreshControl = UIRefreshControl()
    private let provinceCellIdentifier = "ProvinceTableViewCell"
    
    var presenter: ViewToPresenterCountryDetailsProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.pullToRefresh()
        presenter?.viewDidLoad()
        self.showHUD()
    }

    // MARK: - UI Setup
    func setupUI() {
        self.provinceListView.register(UINib(nibName: provinceCellIdentifier, bundle: nil), forCellReuseIdentifier: provinceCellIdentifier)
        self.emptyView.isHidden = true
        self.countryImageView.layer.cornerRadius = 10
        self.countryImageView.layer.masksToBounds = true
        self.countryImageView.layer.borderWidth = 1.5
        self.countryImageView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func pullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Load more")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        provinceListView.addSubview(refreshControl)
    }
   
    
    // MARK: - Actions
    @objc func refresh(refreshControl: UIRefreshControl) {
        presenter?.refresh()
    }

}

// MARK: - UITableView Delegate & Data Source

extension CountryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: provinceCellIdentifier, for: indexPath) as? ProvinceTableViewCell else {
            return UITableViewCell()
        }
        
        if let province = presenter?.provinceAt(index: indexPath.row) {
            cell.configureCell(province: province)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
}

// MARK: - Presenter To View Delegate Methods
extension CountryDetailsViewController: PresenterToViewCountryDetailsProtocol {    
    func onGetImageURL(_ countryName: String, imageURL: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.countryImageView.url(imageURL)
            self.navigationItem.title = countryName
        }
    }
    
    func onGetProvincesSuccess(provinceIsEmpty: Bool) {
        DispatchQueue.main.async {
            self.hideHUD()
            self.provinceListView.isHidden = provinceIsEmpty
            self.emptyView.isHidden = !provinceIsEmpty
            self.refreshControl.endRefreshing()
            self.provinceListView.reloadData()
        }
    }
    
    func onGetProvincesFailure(error: String) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.hideHUD()
            self.provinceListView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
    
    func onGetImageFromURLFailure(_ countryName: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = countryName
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
