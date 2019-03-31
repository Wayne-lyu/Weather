//
//  LocationService.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/31.
//

import UIKit
import Foundation
import CoreLocation

extension Notification.Name {

    static let newLocation = Notification.Name("newLocation")
}

class LocationService : NSObject {

    static var shared = LocationService()

    var currentUserLocation: CLLocation?

    fileprivate enum Constants {

        static let minDistanceToTravel: CLLocationDistance = 1000.0
        static let queueName = "com.wayne.weather.locationmanager"
    }

    fileprivate let internalQueue: DispatchQueue

    fileprivate(set) lazy var manager: CLLocationManager = {

        let locationManager = CLLocationManager()
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.activityType = .other
        locationManager.distanceFilter = Constants.minDistanceToTravel
        return locationManager
    }()

    override init() {

        self.internalQueue = DispatchQueue(
            label:  "\(Constants.queueName).\(ProcessInfo.processInfo.globallyUniqueString)",
            qos: .userInitiated
        )

        super.init()
        self.manager.delegate = self
    }

    func requestLocation() {

        self.internalQueue.async {

            print("📍Requesting location...")
            self.manager.requestLocation()
        }
    }

    func requestLocationServicesAlwaysAuthorization() {

        self.manager.requestAlwaysAuthorization()
    }

    func requestPermissionsOrRedirectIfNeeded() {

        if LocationService.isLocationServicesNotRequested() {

            self.requestLocationServicesAlwaysAuthorization()

        } else if let appSettings = URL(string: UIApplication.openSettingsURLString) {

            UIApplication.shared.open(appSettings)
        }
    }

    class func isLocationServicesNotRequested() -> Bool {

        return CLLocationManager.authorizationStatus() == .notDetermined
    }

    class func isLocationServicesAuthorizedAlways() -> Bool {

        return CLLocationManager.authorizationStatus() == .authorizedAlways
    }

    class func isLocationServicesAuthorizedWhenInUse() -> Bool {

        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }

    class func isLocationServicesEnabled() -> Bool {

        return CLLocationManager.locationServicesEnabled() &&
            [.authorizedWhenInUse, .authorizedAlways].contains(CLLocationManager.authorizationStatus())
    }

}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        self.internalQueue.async {

            print("located successfully")

            self.currentUserLocation = locations.first

            NotificationCenter.default.post(name: .newLocation, object: self, userInfo: nil)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        self.internalQueue.async {

            print("located with error")
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
            self.requestLocation()
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
            self.requestLocation()
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
}

