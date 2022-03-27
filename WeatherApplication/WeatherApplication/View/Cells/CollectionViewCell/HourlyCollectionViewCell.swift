//
//  HourlyCollectionViewCell.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 20.03.2022.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "HourlyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet var iconImageView:UIImageView!
    @IBOutlet var tempLabel:UILabel!
    @IBOutlet var hourlyLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: Current) {
        guard let dt = model.dt else {return}
        guard let temp = model.temp else {return}
        self.hourlyLabel.text = DateFormatting.getHourly(Date(timeIntervalSince1970: Double(dt)))
        self.hourlyLabel.textColor = .white
        self.tempLabel.text = "\(Int(temp - 273.15))°"
        self.tempLabel.textColor = .white
        self.iconImageView.contentMode = .scaleAspectFit
        self.iconImageView.tintColor = .white
        
        Icons.configureCurrentWeather(with: model, iconImageView: iconImageView)
    }
}
