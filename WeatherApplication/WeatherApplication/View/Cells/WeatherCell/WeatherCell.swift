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
        self.dayLabel.text = DateFormatting.getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
        self.tempLabel.text = "\(Int(model.temp.min - 273.15))°/ \(Int(model.temp.max - 273.15))°"
        iconImageView.tintColor = .black
        Icons.configureIconsDaily(with: model, iconImageView: iconImageView)

 }
}
