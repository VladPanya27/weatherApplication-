//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import UIKit
import CoreLocation
import SnapKit

class MainViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dayLabel = UILabel()
    
    private let tempLabel = UILabel()
    
    private let humidityLabel = UILabel()
    
    private let windLabel = UILabel()
    
    private let timezoneLabel = UILabel()
    
    private let weatherImage = UIImageView()
    
    private let viewModel = MainViewModel()
    
    private let locationManager = CLLocationManager()
    
    private var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        requestLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor.weatherBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func loadData(model:CLLocationCoordinate2D) {
        viewModel.loadDataWeather(lat: model.latitude, lon: model.longitude) { [weak self] in
            self?.reloadTable()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.tableHeaderView = self.createTableHeader()
        }
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HourlyCell.nib(), forCellReuseIdentifier: HourlyCell.identifire)
        tableView.register(WeatherCell.nib(), forCellReuseIdentifier: WeatherCell.identifire)
        tableView.backgroundColor = UIColor.weatherBlue
        tableView.allowsSelection = true
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
            cell.configure(with: viewModel.hourlyWeatherModel)
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
            return 70
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? WeatherCell {
            cell.dayLabel.textColor = UIColor.weatherLightBlue
            cell.tempLabel.textColor = UIColor.weatherLightBlue
            cell.iconImageView.tintColor = UIColor.weatherLightBlue
            cell.contentView.tintColor = UIColor.weatherLightBlue
        }
        
        let daily = viewModel.dailyWeatherModel[indexPath.row]
        let hourly = viewModel.hourlyWeatherModel[indexPath.row]
        dayLabel.text = DateFormatting.getMonth(Date(timeIntervalSince1970: Double(daily.dt!)))
        tempLabel.text = Converter.fahrenheitToCelsius(with: daily)
        humidityLabel.text = "\(String(describing: hourly.humidity!))%"
        
        if let wind =  hourly.windSpeed, let windDeg = Compass.direction(for: Double(hourly.windDeg!)) {
            self.windLabel.text = "\(String(describing:Int(wind)))" + "м/сек" + " " + "\(String(describing: windDeg))"
            Icons.configureDailyWeather(with: daily, iconImageView: weatherImage)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? WeatherCell {
            cell.dayLabel.textColor = UIColor.black
            cell.tempLabel.textColor = UIColor.black
            cell.iconImageView.tintColor = UIColor.black
        }
    }
    
    private func createTableHeader() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.4))
        
        headerView.backgroundColor = UIColor.weatherBlue
        
        let imageLocation = UIImageView(image: UIImage(named: "icons-location"))
        headerView.addSubview(imageLocation)
        
        imageLocation.snp.makeConstraints { maker in
            maker.left.equalTo(headerView).inset(10)
            maker.top.equalTo(headerView).inset(10)
            maker.height.equalTo(20)
            maker.width.equalTo(20)
        }
        
        let timezone = ReplacingString.replacing(with: viewModel.weatherModel?.timezone ?? "")
        timezoneLabel.text = timezone
        timezoneLabel.textColor = .white
        timezoneLabel.font = UIFont.systemFont(ofSize: 20)
        headerView.addSubview(timezoneLabel)
        
        timezoneLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageLocation).inset(30)
            maker.right.equalTo(headerView).inset(30)
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
            
            locationButton.addTarget(self, action: #selector(presentMap), for: .touchUpInside)
        }
        
        let searchButton = UIButton()
        searchButton.setImage(UIImage(named: "search"), for: UIControl.State.normal)
        headerView.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { maker in
            maker.trailing.equalTo(locationButton).inset(40)
            maker.top.equalTo(headerView).inset(14)
            maker.height.equalTo(20)
            maker.width.equalTo(20)
            
            searchButton.addTarget(self, action: #selector(presentSearch), for: .touchUpInside)
        }
        
        if let data = viewModel.currentWeatherModel?.dt {
            self.dayLabel.text = DateFormatting.getMonth(Date(timeIntervalSince1970: Double(data)))
        }
        self.dayLabel.textColor = .white
        self.dayLabel.font = UIFont.systemFont(ofSize: 15)
        headerView.addSubview(dayLabel)
        
        self.dayLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageLocation).inset(10)
            maker.top.equalTo(imageLocation).inset(40)
        }
        
        self.weatherImage.tintColor = .white
        Icons.configureCurrentWeather(with: viewModel.currentWeatherModel!, iconImageView: self.weatherImage)
        headerView.addSubview(self.weatherImage)
        
        self.weatherImage.snp.makeConstraints { maker in
            maker.left.equalTo(headerView).inset(30)
            maker.top.equalTo(headerView).inset(100)
            maker.height.equalTo(120)
            maker.width.equalTo(150)
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
        
        if let tempMin = viewModel.dailyWeatherModel[0].temp?.min, let tempMax = viewModel.dailyWeatherModel[0].temp?.max  {
            self.tempLabel.text = "\(Int((tempMin) - 273.15))°/ \(Int((tempMax) - 273.15))°"
            
            self.tempLabel.textColor = .white
            self.tempLabel.font = UIFont.systemFont(ofSize: 20)
            headerView.addSubview(self.tempLabel)
            
            self.tempLabel.snp.makeConstraints { maker in
                maker.left.equalTo(imageTemp).inset(40)
                maker.top.equalTo(headerView).inset(120)
            }
        }
        
        let himidityImage = UIImageView(image: UIImage(named: "humidity"))
        himidityImage.tintColor = .white
        headerView.addSubview(himidityImage)
        
        himidityImage.snp.makeConstraints { maker in
            maker.trailing.equalTo(headerView).inset(120)
            maker.top.equalTo(imageTemp).inset(35)
            maker.height.equalTo(25)
            maker.width.equalTo(25)
            
        }
        
        if let humidity = viewModel.currentWeatherModel?.humidity {
            self.humidityLabel.text = "\(String(describing: humidity))%"
        }
        self.humidityLabel.textColor = .white
        self.humidityLabel.font = UIFont.systemFont(ofSize: 20)
        headerView.addSubview(self.humidityLabel)
        
        self.humidityLabel.snp.makeConstraints { maker in
            maker.left.equalTo(himidityImage).inset(40)
            maker.top.equalTo(tempLabel).inset(35)
        }
        
        let windImage = UIImageView(image: UIImage(named: "wind"))
        windImage.tintColor = .white
        headerView.addSubview(windImage)
        
        windImage.snp.makeConstraints { maker in
            maker.trailing.equalTo(headerView).inset(120)
            maker.top.equalTo(himidityImage).inset(35)
            maker.height.equalTo(25)
            maker.width.equalTo(25)
        }
        
        if let wind =  viewModel.currentWeatherModel?.windSpeed, let windDeg = Compass.direction(for: Double(viewModel.currentWeatherModel!.windDeg!)) {
            self.windLabel.text = "\(String(describing:Int(wind)))" + "м/сек" + " " + "\(String(describing: windDeg))"
        }
        self.windLabel.textColor = .white
        self.windLabel.font = UIFont.systemFont(ofSize: 20)
        headerView.addSubview(self.windLabel)
        
        self.windLabel.snp.makeConstraints { maker in
            maker.left.equalTo(windImage).inset(40)
            maker.top.equalTo(humidityLabel).inset(35)
        }
        return headerView
    }
    
    @objc private func presentMap() {
        let mapViewController = MapViewController()
        mapViewController.modalPresentationStyle = .fullScreen
        
        mapViewController.completion = { [weak self] model in
            self?.loadData(model: model)
        }
        self.present(mapViewController, animated: true, completion: nil)
    }
    
    @objc private func presentSearch() {
        let searchViewController = SearchViewController()
        
        searchViewController.completion = { [weak self] model in
            self?.loadData(model: model)
        }
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    private func requestLocation() {
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
    
    private func requestWeatherForLocation() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        self.loadData(model: coordinate)
    }
}
