//
//  CountryTableViewCell.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 10/03/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet private weak var flagImage: UIImageView!
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet private weak var countryCodeLabel: UILabel!
    @IBOutlet private weak var phoneCodeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.flagImage.image = nil
    }
    
    func configureCell(county: Country) {
        self.flagImage.layer.cornerRadius = 8
        self.flagImage.layer.masksToBounds = true
        self.flagImage.layer.borderWidth = 0.5
        self.flagImage.layer.borderColor = UIColor.gray.cgColor
        let urlString = APIManager.shared.imageURL + "\(county.Code?.lowercased() ?? "us").png"
        self.flagImage.url(urlString)
        self.countryNameLabel.text = county.Name
        self.countryCodeLabel.text = county.Code
        self.phoneCodeLabel.text = county.PhoneCode
    }
}
