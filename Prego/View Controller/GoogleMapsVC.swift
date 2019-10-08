//
//  GoogleMapsVC.swift
//  Prego
//
//  Created by owner on 10/1/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import GoogleMaps

struct UserAddress {
    let latitude: Double?
    let longitude: Double?
    let country: String?
    let city: String?
    let region: String?
    let street: String?
}

class GoogleMapsVC: UIViewController {
    
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    var userAddress: UserAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationService()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkLocationService(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocatioManager()
            checkLocationAuthorization()
        }
    }
    
    func setupLocatioManager(){
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            break
        case .denied, .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        }
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let _ = address.lines else {
                return
            }
            self.userAddress = UserAddress(latitude: coordinate.latitude, longitude: coordinate.longitude, country: address.country, city: address.administrativeArea, region: address.locality, street: address.thoroughfare)
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        toAddAddress()
    }
    
    func toAddAddress(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "AddAddressVC") as? AddAddressVC {
            if userAddress != nil {
                desVC.userAddress = self.userAddress
            }
            present(desVC, animated: true)
        }
    }
}

extension GoogleMapsVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        //Set my location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

extension GoogleMapsVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
}
