//
//  Icons.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 20.03.2022.
//

import Foundation
import UIKit

class Icons {
    static func configureIconsDaily(with model: Daily, iconImageView: UIImageView ) {

        model.weather!.forEach { if $0.icon!.contains("10d") {
            iconImageView.image = UIImage(systemName:"cloud.rain")
        } else if $0.icon!.contains("01d") {
            iconImageView.image = UIImage(systemName:"sun.max")
        } else {
            iconImageView.image = UIImage(systemName:"cloud.sun")
        }
    }
 }

    static func configureIconsCurrent(with model: Current, iconImageView: UIImageView ) {
        
        
        model.weather!.forEach { if $0.icon!.contains("10d") {
            iconImageView.image = UIImage(systemName:"cloud.rain")
        } else if $0.icon!.contains("01d") {
            iconImageView.image = UIImage(systemName:"sun.max")
        } else {
            iconImageView.image = UIImage(systemName:"cloud.sun")
        }
    }
 }
}
