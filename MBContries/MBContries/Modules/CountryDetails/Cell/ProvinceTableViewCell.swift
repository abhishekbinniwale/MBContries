//
//  ProvinceTableViewCell.swift
//  MBContries
//
//  Created by Abhishek Binniwale on 11/03/23.
//

import UIKit

class ProvinceTableViewCell: UITableViewCell {

    @IBOutlet weak var provinceNameLabel: UILabel!
    @IBOutlet weak var provinceCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(province: Province) {
        self.provinceNameLabel.text = province.Name
        self.provinceCodeLabel.text = province.Code
    }
}
