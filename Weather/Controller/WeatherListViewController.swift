//
//  WeatherListViewController.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import UIKit

class WeatherListViewController: UIViewController {

    private var tableView: UITableView!
    private var list = Set<Forecast>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onNewLocation),
                                               name: .newLocation,
                                               object: nil)
    }

    @objc
    private func didTapDone() {

        if !LocationService.isLocationServicesEnabled() {

            LocationService.shared.requestPermissionsOrRedirectIfNeeded()
        } else {

            LocationService.shared.requestLocation()
        }
    }

    @objc
    private func onNewLocation() {

        guard let coordiate = LocationService.shared.currentUserLocation?.coordinate else {
            return
        }

        DarkSkyService.shared.getForecast(latitude: coordiate.latitude,
                                          longitude: coordiate.longitude) { result in
            switch result {
            case .success(let forecast):
                if self.list.insert(forecast).inserted {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func setupUI() {

        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Forecast", style: .plain, target: self, action: #selector(didTapDone))

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CompactTableViewCell.self, forCellReuseIdentifier: "CompactCell")

        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
    }

}

extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CompactCell", for: indexPath) as!
            CompactTableViewCell

        let forecast = Array(list)[indexPath.row]

        if let icon = forecast.daily?.icon {
            cell.imageView?.image = UIImage(named: icon.rawValue)
        }
        if let summary = forecast.currently?.summary,
            let temperature = forecast.currently?.apparentTemperature {
            cell.titleLabel.text = "\(temperature)˚ \(summary)"
        }
        if let temperatureLow = forecast.daily?.data.first?.temperatureLow,
            let temperatureHigh =  forecast.daily?.data.first?.temperatureHigh{
            cell.subTitleLabel.text = "Low:\(temperatureLow)˚ High:\(temperatureHigh)˚"
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let daily = Array(list)[indexPath.row].daily?.data else {
            return
        }

        let detailVC = WeatherDetailViewController()
        detailVC.list = daily
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
