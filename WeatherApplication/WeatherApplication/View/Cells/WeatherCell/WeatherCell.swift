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
        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
        self.tempLabel.text = "\(Int(model.temp.min - 273.15))°/ \(Int(model.temp.max - 273.15))°"

        model.weather.forEach { if $0.icon.contains("10d") {
        self.iconImageView.image = UIImage(systemName:"cloud.rain")
        } else if $0.icon.contains("01d") {
        self.iconImageView.image = UIImage(systemName:"sun.max")
        } else {
        self.iconImageView.image = UIImage(systemName:"cloud.sun")
            }
        }
    }

    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "E" // Monday
        return formatter.string(from: inputDate)
    }
}
