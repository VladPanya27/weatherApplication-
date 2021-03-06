//
//  Icons.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 20.03.2022.
//

import Foundation
import UIKit

class Icons {
   
    static func configureDailyWeather(with model: Daily?, iconImageView: UIImageView ) {
        guard let model = model else {return}
        
        model.weather!.forEach { if $0.icon!.rawValue.contains("10d") {
            iconImageView.image = UIImage(systemName:"cloud.rain")
        } else if $0.icon!.rawValue.contains("01d") {
            iconImageView.image = UIImage(systemName:"sun.max")
        } else {
            iconImageView.image = UIImage(systemName:"cloud.sun")
        }
        }
    }
    
    static func configureCurrentWeather(with model: Current?, iconImageView: UIImageView ) {
        guard let model = model else {return}
        
        model.weather!.forEach { if $0.icon!.rawValue.contains("10d") {
            iconImageView.image = UIImage(systemName:"cloud.rain")
        } else if $0.icon!.rawValue.contains("01d") {
            iconImageView.image = UIImage(systemName:"sun.max")
        } else {
            iconImageView.image = UIImage(systemName:"cloud.sun")
        }
        }
    }
}
