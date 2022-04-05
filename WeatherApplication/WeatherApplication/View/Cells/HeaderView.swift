//
//  HeaderView.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 02.04.2022.
//

import UIKit

public class HeaderView: UIView {

    @IBOutlet var view: UIView!
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timezoneImage: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    
     func createTableHeader() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.4))
        
        headerView.backgroundColor = UIColor.weatherBlue
        
//        let imageLocation = UIImageView(image: UIImage(named: "icons-location"))
//        headerView.addSubview(imageLocation)
//
//        imageLocation.snp.makeConstraints { maker in
//            maker.left.equalTo(headerView).inset(10)
//            maker.top.equalTo(headerView).inset(10)
//            maker.height.equalTo(20)
//            maker.width.equalTo(20)
//        }
//
//        let timezone = ReplacingString.replacing(with: viewModel.weatherModel?.timezone ?? "")
//        timezoneLabel.text = timezone
//        timezoneLabel.textColor = .white
//        timezoneLabel.font = UIFont.systemFont(ofSize: 20)
//        headerView.addSubview(timezoneLabel)
//
//        timezoneLabel.snp.makeConstraints { maker in
//            maker.left.equalTo(imageLocation).inset(30)
//            maker.right.equalTo(headerView).inset(30)
//            maker.top.equalTo(imageLocation).inset(0)
//        }
//
//        let locationButton = UIButton()
//        locationButton.setImage(UIImage(named: "-gps"), for: UIControl.State.normal)
//        headerView.addSubview(locationButton)
//
//        locationButton.snp.makeConstraints { maker in
//            maker.trailing.equalTo(headerView).inset(10)
//            maker.top.equalTo(headerView).inset(10)
//            maker.height.equalTo(25)
//            maker.width.equalTo(25)
//
//            locationButton.addTarget(self, action: #selector(presentMap), for: .touchUpInside)
//        }
//
//        let searchButton = UIButton()
//        searchButton.setImage(UIImage(named: "search"), for: UIControl.State.normal)
//        headerView.addSubview(searchButton)
//
//        searchButton.snp.makeConstraints { maker in
//            maker.trailing.equalTo(locationButton).inset(40)
//            maker.top.equalTo(headerView).inset(14)
//            maker.height.equalTo(20)
//            maker.width.equalTo(20)
//
//            searchButton.addTarget(self, action: #selector(presentSearch), for: .touchUpInside)
//        }
//
//        if let data = viewModel.currentWeatherModel?.dt {
//            self.dayLabel.text = DateFormatting.getMonth(Date(timeIntervalSince1970: Double(data)))
//        }
//        self.dayLabel.textColor = .white
//        self.dayLabel.font = UIFont.systemFont(ofSize: 15)
//        headerView.addSubview(dayLabel)
//
//        self.dayLabel.snp.makeConstraints { maker in
//            maker.left.equalTo(imageLocation).inset(10)
//            maker.top.equalTo(imageLocation).inset(40)
//        }
//
//        self.weatherImage.tintColor = .white
//        Icons.configureCurrentWeather(with: viewModel.currentWeatherModel!, iconImageView: self.weatherImage)
//        headerView.addSubview(self.weatherImage)
//
//        self.weatherImage.snp.makeConstraints { maker in
//            maker.left.equalTo(headerView).inset(30)
//            maker.top.equalTo(headerView).inset(100)
//            maker.height.equalTo(120)
//            maker.width.equalTo(150)
//        }
//
//        let imageTemp = UIImageView(image: UIImage(systemName: "thermometer"))
//        imageTemp.tintColor = .white
//        headerView.addSubview(imageTemp)
//
//        imageTemp.snp.makeConstraints { maker in
//            maker.trailing.equalTo(headerView).inset(120)
//            maker.top.equalTo(headerView).inset(120)
//            maker.height.equalTo(25)
//            maker.width.equalTo(25)
//        }
//
//        if let tempMin = viewModel.dailyWeatherModel[0].temp?.min, let tempMax = viewModel.dailyWeatherModel[0].temp?.max  {
//            self.tempLabel.text = "\(Int((tempMin) - 273.15))°/ \(Int((tempMax) - 273.15))°"
//
//            self.tempLabel.textColor = .white
//            self.tempLabel.font = UIFont.systemFont(ofSize: 20)
//            headerView.addSubview(self.tempLabel)
//
//            self.tempLabel.snp.makeConstraints { maker in
//                maker.left.equalTo(imageTemp).inset(40)
//                maker.top.equalTo(headerView).inset(120)
//            }
//        }
//
//        let himidityImage = UIImageView(image: UIImage(named: "humidity"))
//        himidityImage.tintColor = .white
//        headerView.addSubview(himidityImage)
//
//        himidityImage.snp.makeConstraints { maker in
//            maker.trailing.equalTo(headerView).inset(120)
//            maker.top.equalTo(imageTemp).inset(35)
//            maker.height.equalTo(25)
//            maker.width.equalTo(25)
//
//        }
//
//        if let humidity = viewModel.currentWeatherModel?.humidity {
//            self.humidityLabel.text = "\(String(describing: humidity))%"
//        }
//        self.humidityLabel.textColor = .white
//        self.humidityLabel.font = UIFont.systemFont(ofSize: 20)
//        headerView.addSubview(self.humidityLabel)
//
//        self.humidityLabel.snp.makeConstraints { maker in
//            maker.left.equalTo(himidityImage).inset(40)
//            maker.top.equalTo(tempLabel).inset(35)
//        }
//
//        let windImage = UIImageView(image: UIImage(named: "wind"))
//        windImage.tintColor = .white
//        headerView.addSubview(windImage)
//
//        windImage.snp.makeConstraints { maker in
//            maker.trailing.equalTo(headerView).inset(120)
//            maker.top.equalTo(himidityImage).inset(35)
//            maker.height.equalTo(25)
//            maker.width.equalTo(25)
//        }
//
//        if let wind =  viewModel.currentWeatherModel?.windSpeed, let windDeg = Compass.direction(for: Double(viewModel.currentWeatherModel!.windDeg!)) {
//            self.windLabel.text = "\(String(describing:Int(wind)))" + "м/сек" + " " + "\(String(describing: windDeg))"
//        }
//        self.windLabel.textColor = .white
//        self.windLabel.font = UIFont.systemFont(ofSize: 20)
//        headerView.addSubview(self.windLabel)
//
//        self.windLabel.snp.makeConstraints { maker in
//            maker.left.equalTo(windImage).inset(40)
//            maker.top.equalTo(humidityLabel).inset(35)
//        }
        return headerView
    }
    
}
