//
//  RouteMapVC.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/8/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit
import MapKit
import SCLAlertView

class RouteMapVC: UIViewController{
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var passedCoordinate: CLLocationCoordinate2D!
    let locationManager = CLLocationManager()
    var userCoordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        setDestination()
        centerMapOnLocation()
        locationManager.startUpdatingLocation()
        userCoordinate = locationManager.location?.coordinate
        
    }
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func makeRoutePressed(_ sender: Any) {
        buildRoute()
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
    
    func setDestination() {
        let CLLCoordType = CLLocationCoordinate2D(latitude: passedCoordinate.latitude, longitude: passedCoordinate.longitude)
        let anno = MKPointAnnotation()
        anno.coordinate = CLLCoordType
        mapView.addAnnotation(anno)
    }
    
    // Increse visibility of place
    func centerMapOnLocation() {
        let coordinationRegion = MKCoordinateRegionMakeWithDistance(passedCoordinate, 2000, 2000)
        mapView.setRegion(coordinationRegion, animated: true)
    }
    
    
    
    func buildRoute() {
        
        guard let cl = userCoordinate else {
            SCLAlertView().showInfo("No current location", subTitle: "Please grant access")
            return
        }
        let sourcePlacemark = MKPlacemark(coordinate: cl, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: passedCoordinate, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Это вы :)"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Огого куда вам надо. Считсливого пути !!!"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            let distance = response.routes[0].distance
            
            self.distanceLabel.text = "Distance: \(distance/1000) km"
            
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(colorLiteralRed: 0, green: 0, blue: 255, alpha: 0.7)
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userCoordinate = manager.location?.coordinate
        print(userCoordinate ?? "no current location")
    }
}
