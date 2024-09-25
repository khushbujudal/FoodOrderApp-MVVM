//
//  Location.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 28/08/24.
//

import Foundation
import CoreLocation

final class Location: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var lastKnownLocation: CLLocationCoordinate2D?
    @Published var currentLocation : String?
    var manager = CLLocationManager()
    
    func checkLocationAuthorization() {
        
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Resticted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("location Authorized always")
        case .authorizedWhenInUse:
            print("location Authorized when in use")
            lastKnownLocation = manager.location?.coordinate
            converToAddress()
        @unknown default:
            print("Location service disabled")
        }
    }
    
    
    func converToAddress() {
        
        if let lastLocation = lastKnownLocation {
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
               
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (places, error) -> Void in
                if error == nil{
                    let placeMark = places! as [CLPlacemark]
                    
                    if placeMark.count > 0 {
                        let placeMark = places![0]
                        var addressString : String = ""
                        
                        if placeMark.subThoroughfare != nil {
                            addressString = addressString + placeMark.subThoroughfare! + ", "
                        }
                        if placeMark.thoroughfare != nil {
                            addressString = addressString + placeMark.thoroughfare! + ", "
                        }
                        if placeMark.subLocality != nil {
                            addressString = addressString + placeMark.subLocality! + ", "
                        }
                        
                        if placeMark.locality != nil {
                            addressString = addressString + placeMark.locality! + ", "
                        }
                        if placeMark.administrativeArea != nil {
                            addressString = addressString + placeMark.administrativeArea! + ", "
                        }
                        if placeMark.country != nil {
                            addressString = addressString + placeMark.country! + ", "
                        }
                        if placeMark.postalCode != nil {
                            addressString = addressString + placeMark.postalCode! + " "
                        }
                        
                        self.currentLocation = addressString
                    }
                }
            })
        }
    }
}
