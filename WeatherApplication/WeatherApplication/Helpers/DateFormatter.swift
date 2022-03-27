//
//  DateFormatter.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 20.03.2022.
//

import Foundation

class DateFormatting {

    static func getDay(_ date: Date?) -> String {
    guard let inputDate = date else {
        return ""
    }

    let formatter = DateFormatter()
    formatter.dateFormat = "E"
    return formatter.string(from: inputDate)
    }
    
    static func getMonth(_ date: Date?) -> String {
    guard let inputDate = date else {
        return ""
    }

    let formatter = DateFormatter()
    formatter.dateFormat = "eee, MMM dd"
    return formatter.string(from: inputDate)
    }

    static func getHourly(_ date: Date?) -> String {
    guard let inputDate = date else {
        return ""
    }

    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm" 
    return formatter.string(from: inputDate)
    }
}
