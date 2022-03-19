//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import UIKit
import CoreLocation

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
    }
    
}
    
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
        
    func prepareTableView() {
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(HourlyCell.nib(), forCellReuseIdentifier: HourlyCell.identifire)
         tableView.register(WeatherCell.nib(), forCellReuseIdentifier: WeatherCell.identifire)
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.weatherModel.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let array = viewModel.weatherModel[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = array.timezone
        return cell
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
            }
        }
    }
}
