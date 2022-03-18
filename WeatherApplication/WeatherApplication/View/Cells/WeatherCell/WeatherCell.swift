//
//  WeatherCell.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import UIKit

class WeatherCell: UITableViewCell {

    static let identifire = "WeatherCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
