//
//  WeatherCell.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
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
    
    func configure(with model: Daily) {
        guard let dt = model.dt else {return}
        self.dayLabel.text = DateFormatting.getDay(Date(timeIntervalSince1970: Double(dt)))
        self.tempLabel.text = Converter.fahrenheitToCelsius(with: model)
        iconImageView.tintColor = .black
        
        Icons.configureDailyWeather(with: model, iconImageView: iconImageView)
    }
}
