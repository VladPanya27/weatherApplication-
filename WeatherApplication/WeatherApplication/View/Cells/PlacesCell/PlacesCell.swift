//
//  PlacesCell.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 27.03.2022.
//

import UIKit

class PlacesCell: UITableViewCell {

    static let identifire = "PlacesCell"

    static func nib() -> UINib {
        return UINib(nibName: "PlacesCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
