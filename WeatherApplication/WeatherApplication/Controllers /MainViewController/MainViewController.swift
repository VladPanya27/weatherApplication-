//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

// По нажатию на ячейку менять цвет текста и показать на главном екране погоду

import UIKit
import CoreLocation
import SnapKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    let viewModel = ViewModelMainController()
    
    let locationManager = CLLocationManager()

    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
        view.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
    
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
        
    func prepareTableView() {
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(HourlyCell.nib(), forCellReuseIdentifier: HourlyCell.identifire)
         tableView.register(WeatherCell.nib(), forCellReuseIdentifier: WeatherCell.identifire)
         tableView.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
            return viewModel.dailyWeatherModel.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourlyCell.identifire, for: indexPath) as! HourlyCell
            cell.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)

            cell.configure(with: viewModel.hourly)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifire, for: indexPath) as! WeatherCell
            cell.configure(with: viewModel.dailyWeatherModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 145
        } else {
            return 60
        }
    }
    
    func createTableHeader() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.4))
            

        headerView.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        
        let imageLocation = UIImageView(image: UIImage(named: "icons-location"))
            headerView.addSubview(imageLocation)
        
            imageLocation.snp.makeConstraints { maker in
                maker.left.equalTo(headerView).inset(10)
                maker.top.equalTo(headerView).inset(10)
                maker.height.equalTo(20)
                maker.width.equalTo(20)
        }

        let cityLabel = UILabel()
        let city = ReplacingString.replacing(with: viewModel.weatherModel!.timezone)
            cityLabel.text = city
            cityLabel.textColor = .white
            cityLabel.font = UIFont.systemFont(ofSize: 20)
            headerView.addSubview(cityLabel)
            
            cityLabel.snp.makeConstraints { maker in
                maker.left.equalTo(imageLocation).inset(30)
                maker.top.equalTo(imageLocation).inset(0)
        }
        
        let locationButton = UIButton()
            locationButton.setImage(UIImage(named: "-gps"), for: UIControl.State.normal)
            headerView.addSubview(locationButton)
        
            locationButton.snp.makeConstraints { maker in
                maker.trailing.equalTo(headerView).inset(10)
                maker.top.equalTo(headerView).inset(10)
                maker.height.equalTo(25)
                maker.width.equalTo(25)
          
                locationButton.addTarget(self, action: #selector(pushMap), for: .touchUpInside)
            }
        
        let searchButton = UIButton()
            searchButton.setImage(UIImage(named: "search"), for: UIControl.State.normal)
            headerView.addSubview(searchButton)
        
                searchButton.snp.makeConstraints { maker in
                maker.trailing.equalTo(locationButton).inset(40)
                maker.top.equalTo(headerView).inset(14)
                maker.height.equalTo(20)
                maker.width.equalTo(20)
          
        }
        
        let dayLabel = UILabel()
        if let dt = viewModel.current?.dt {
            dayLabel.text = DateFormatting.getMonthForDates(Date(timeIntervalSince1970: Double(dt)))
        }
            dayLabel.textColor = .white
            dayLabel.font = UIFont.systemFont(ofSize: 15)
        
            headerView.addSubview(dayLabel)
            
            dayLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageLocation).inset(10)
            maker.top.equalTo(imageLocation).inset(40)
        }
        
        let imageWeather = UIImageView()
            imageWeather.tintColor = .white
            Icons.configureIconsCurrent(with: viewModel.current!, iconImageView: imageWeather)
            headerView.addSubview(imageWeather)
        
            imageWeather.snp.makeConstraints { maker in
                maker.left.equalTo(headerView).inset(30)
                maker.top.equalTo(headerView).inset(100)
                maker.height.equalTo(120)
                maker.width.equalTo(140)
          
        }
        
        let imageTemp = UIImageView(image: UIImage(systemName: "thermometer"))
            
            imageTemp.tintColor = .white
            headerView.addSubview(imageTemp)
        
            imageTemp.snp.makeConstraints { maker in
                maker.trailing.equalTo(headerView).inset(120)
                maker.top.equalTo(headerView).inset(120)
                maker.height.equalTo(25)
                maker.width.equalTo(25)
          
        }
        
        let tempLabel = UILabel()
            tempLabel.text = "\(Int(viewModel.dailyWeatherModel[0].temp.min - 273.15))°/ \(Int(viewModel.dailyWeatherModel[0].temp.max - 273.15))°"
        
            tempLabel.textColor = .white
            tempLabel.font = UIFont.systemFont(ofSize: 20)
        
            headerView.addSubview(tempLabel)
            
            tempLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageTemp).inset(40)
            maker.top.equalTo(headerView).inset(120)
        }
        
        let imageHumidity = UIImageView(image: UIImage(named: "humidity"))
            imageHumidity.tintColor = .white
            headerView.addSubview(imageHumidity)
        
            imageHumidity.snp.makeConstraints { maker in
                maker.trailing.equalTo(headerView).inset(120)
                maker.top.equalTo(imageTemp).inset(35)
                maker.height.equalTo(25)
                maker.width.equalTo(25)
          
        }
        
        let humidityLabel = UILabel()
        
        if let humidity = viewModel.current?.humidity {
            humidityLabel.text = "\(String(describing: humidity))%"
        }
            humidityLabel.textColor = .white
            humidityLabel.font = UIFont.systemFont(ofSize: 20)
        
            headerView.addSubview(humidityLabel)
            
            humidityLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageHumidity).inset(40)
            maker.top.equalTo(tempLabel).inset(35)
        }
        
        let imageWind = UIImageView(image: UIImage(named: "wind"))
            imageWind.tintColor = .white
            headerView.addSubview(imageWind)
        
            imageWind.snp.makeConstraints { maker in
                maker.trailing.equalTo(headerView).inset(120)
                maker.top.equalTo(imageHumidity).inset(35)
                maker.height.equalTo(25)
                maker.width.equalTo(25)
          
        }
        
        let windLabel = UILabel()
        if let wind =  viewModel.current?.windSpeed, let windDeg = Compass.direction(for: Double(viewModel.current!.windDeg)) {
            windLabel.text = "\(String(describing:Int(wind)))" + "м/сек" + " " + "\(String(describing: windDeg))"
        }
            windLabel.textColor = .white
            windLabel.font = UIFont.systemFont(ofSize: 20)
        
            headerView.addSubview(windLabel)
            
            windLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageWind).inset(40)
            maker.top.equalTo(humidityLabel).inset(35)
        }
        
        return headerView
    }
    
    @objc func pushMap() {
        self.navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func setupLocation() {
         locationManager.delegate = self
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
         guard let currentLocation = currentLocation else {
            return
        }
        
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        viewModel.loadDataWeather(lat: lat, lon: lon) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.tableHeaderView = self.createTableHeader()
            }
        }
    }
}
