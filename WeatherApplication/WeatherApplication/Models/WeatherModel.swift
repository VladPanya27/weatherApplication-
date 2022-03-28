//
//  WeatherModel.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import Foundation

class WeatherModel: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let current: Current?
    let minutely: [Minutely]?
    let hourly: [Current]?
    let daily: [Daily]?
    let alerts: [Alert]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily, alerts
    }
}

class Alert: Codable {
    let senderName, event: String?
    let start, end: Int?
    let alertDescription: String?
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event, start, end
        case alertDescription = "description"
        case tags
    }
}

class Current: Codable {
    let dt: Int?
    let sunrise, sunset: Int?
    let temp, feelsLike: Double?
    let pressure, humidity: Int?
    let dewPoint, uvi: Double?
    let clouds, visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let weather: [Weather]?
    let rain: Rain?
    let pop: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, rain, pop
    }
}

class Rain: Codable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

class Weather: Codable {
    let id: Int?
    let main: Main?
    let icon: Icon

    enum CodingKeys: String, CodingKey {
        case id, main
        case icon
    }
}

enum Icon: String, Codable {
    case the01D = "01d"
    case the01N = "01n"
    case the02N = "02n"
    case the03N = "03n"
    case the50D = "50d"
    case the10N = "10n"
    case the04N = "04n"
    case the10D = "10d"
    case the04D = "04d"
    case the03D = "03d"
    case the02D = "02d"
    case the13D = "13d"
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
    case haze = "Haze"
}

class Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int?
    let moonset: Int?
    let moonPhase: Double?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure, humidity: Int?
    let dewPoint, windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let weather: [Weather]?
    let clouds: Int?
    let pop: Double?
    let rain: Double?
    let uvi: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi
    }
}

class FeelsLike: Codable {
    let day, night, eve, morn: Double?
}

class Temp: Codable {
    let day, min, max, night: Double?
    let eve, morn: Double?

}

class Minutely: Codable {
    let dt: Int?
    let precipitation: Double?
}
