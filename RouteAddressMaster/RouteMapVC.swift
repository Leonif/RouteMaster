//
//  RouteMapVC.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/8/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit
import MapKit

class RouteMapVC: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    var coordinate: CLLocationCoordinate2D!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        setLocation()
        centerMapOnLocation()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func setLocation() {
        
        let CLLCoordType = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let anno = MKPointAnnotation()
        anno.coordinate = CLLCoordType
        mapView.addAnnotation(anno)
    }
    
    func centerMapOnLocation() {
        let coordinationRegion = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000)
        mapView.setRegion(coordinationRegion, animated: true)
    }
    
    
    
}

// Map works
extension RouteMapVC: MKMapViewDelegate, CLLocationManagerDelegate  {
    
    
    
    
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    
    
    
}
