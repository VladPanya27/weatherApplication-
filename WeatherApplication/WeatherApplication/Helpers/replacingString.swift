//
//  replacingString.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 22.03.2022.
//

import Foundation

class ReplacingString {
    
    static func replacing(with timezone: String) -> String? {
        let timezone = timezone.replacingOccurrences(of: "/", with: ", ").replacingOccurrences(of: "_", with: " ")
    
        return timezone
    }
}
