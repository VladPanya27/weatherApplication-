//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

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
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.dailyWeatherModel.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WeatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifire, for: indexPath) as! WeatherCell
        cell.configure(with: viewModel.dailyWeatherModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
            cityLabel.text = viewModel.weatherModel?.timezone
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
          
        }
        
        let dayLabel = UILabel()
        if let dt = viewModel.current?.dt {
            dayLabel.text = DateFormatting.getDayForDates(Date(timeIntervalSince1970: Double(dt)))
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
            Icons.configureIcons(with: viewModel.dailyWeatherModel[0], iconImageView: imageWeather)
            headerView.addSubview(imageWeather)
        
            imageWeather.snp.makeConstraints { maker in
                maker.left.equalTo(headerView).inset(30)
                maker.top.equalTo(headerView).inset(100)
                maker.height.equalTo(120)
                maker.width.equalTo(180)
          
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
                maker.top.equalTo(imageTemp).inset(30)
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
            maker.top.equalTo(tempLabel).inset(30)
        }
        
        let imageWind = UIImageView(image: UIImage(named: "wind"))
            imageWind.tintColor = .white
            headerView.addSubview(imageWind)
        
            imageWind.snp.makeConstraints { maker in
                maker.trailing.equalTo(headerView).inset(120)
                maker.top.equalTo(imageHumidity).inset(30)
                maker.height.equalTo(25)
                maker.width.equalTo(25)
          
        }
        
        let windLabel = UILabel()
        if let wind =  viewModel.current?.windSpeed, let windDeg = viewModel.current?.windDeg  {
            windLabel.text = "\(String(describing:Int(wind)))" + "" + "\(String(describing: windDeg))" // указать направление ветра из градусов
        }
            windLabel.textColor = .white
            windLabel.font = UIFont.systemFont(ofSize: 20)
        
            headerView.addSubview(windLabel)
            
            windLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageWind).inset(40)
            maker.top.equalTo(humidityLabel).inset(30)
        }
        
        return headerView
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
