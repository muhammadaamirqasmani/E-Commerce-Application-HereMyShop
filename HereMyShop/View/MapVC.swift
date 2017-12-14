//
//  MapVC.swift
//  HereMyShop
//
//  Created by admin on 13/12/2017.
//  Copyright © 2017 MuhammadAamir. All rights reserved.
//

import UIKit
import GoogleMaps


class MapVC: UIViewController,GMSMapViewDelegate {

    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var location: CLLocation?
    var camera: GMSCameraPosition!
//    var clusterManager: GMUClusterManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Google Map View Created and added on viewController...
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true
        // Creates a marker in the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }


}
extension MapVC: CLLocationManagerDelegate{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        print("Location: \(String(describing: location))")
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 15)
        
        if mapView.isHidden {
            mapView.isHidden = false
            
            mapView.camera = camera
        } else {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
            marker.title = "User Here"
            marker.snippet = "This is your location"
            //            marker.tracksInfoWindowChanges = true
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.icon = GMSMarker.markerImage(with: .blue)
            marker.map = mapView
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

