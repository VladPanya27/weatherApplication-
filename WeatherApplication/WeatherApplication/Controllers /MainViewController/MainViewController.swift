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
        return 100
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
    
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        headerView.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)

        
        return headerView
    }

}
