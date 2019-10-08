//
//  AddressMapVC.swift
//  Prego
//
//  Created by owner on 9/23/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddressMapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    let toAddAddressSegue = "toAddAddress"
    let distanceInMeters: Double = 200
    var previousLocation: CLLocation?
    
    var country: String = ""
    var city: String = ""
    var area: String = ""
    var street: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLocationService()
    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        //annotation.title = "Some Title"
        //annotation.subtitle = "Some Subtitle"
        self.mapView.addAnnotation(annotation)
    }
    
    func checkLocationService(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocatioManager()
            checkLocationAuthorization()
        }
    }
    
    func setupLocatioManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(location, distanceInMeters, distanceInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            startTackingUserLocation()
            break
        case .denied, .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        }
    }
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        toAddAddress()
    }
    
    func toAddAddress(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "AddAddressVC") as? AddAddressVC {
            desVC.country = country
            desVC.city = city
            desVC.area = area
            desVC.street = street
            present(desVC, animated: true)
        }
    }
}


extension AddressMapVC : CLLocationManagerDelegate  {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension AddressMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard case self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            let areaName = placemark.locality ?? ""
            let countryName = placemark.country ?? ""
            let subLocality = placemark.subLocality ?? ""
            let cityName = placemark.administrativeArea ?? ""
            
            DispatchQueue.main.async {
                self?.country = countryName
                self?.area = areaName
                self?.city = cityName
                self?.street = streetName
                print("address is \(streetNumber)  \(streetName)")
                print("address a7aa \(areaName)  \(countryName)  \(subLocality) ")
                print("address city \(cityName)")
                //self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
}



