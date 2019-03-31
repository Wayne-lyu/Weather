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
                self.list.insert(forecast)
                self.tableView.reloadData()
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
        tableView.register(RichTableViewCell.self, forCellReuseIdentifier: "RichCell")

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
        if let summary = forecast.daily?.summary {
            cell.titleLabel.text = summary
        }
        if let apparentTemperature = forecast.currently?.apparentTemperature {
            cell.subTitleLabel.text = String(apparentTemperature)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.navigationController?.pushViewController(WeatherDetailViewController(), animated: true)
    }
}
