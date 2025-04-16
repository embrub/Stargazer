//
//  LocationManager.swift
//  Stargazer
//
//  Created by emi n on 4/14/25.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ coordinate: CLLocationCoordinate2D)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    func checkLocationAuthorization() {
        print("Checking authorization status: \(manager.authorizationStatus.rawValue)")

        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways:
            print("Location authorizedAlways")
        case .authorizedWhenInUse:
            print("Location authorized when in use")
            if let coordinate = manager.location?.coordinate {
                delegate?.didUpdateLocation(coordinate)
            }
        @unknown default:
            print("Location service disabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got updated location: \(locations)")
        if let coordinate = locations.first?.coordinate {
            delegate?.didUpdateLocation(coordinate)
        }
    }
}
