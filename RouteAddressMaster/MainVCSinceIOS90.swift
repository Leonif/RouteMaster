//
//  MainVCSinceIOS90.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/8/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainVCSinceIOS90: UIViewController  {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var backImg: UIImageView!
    var placemarksResuts: [CLPlacemark]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func addressChanged(_ sender: Any) {
        print(addressTextField.text ?? "")
        // give address to geocoder
        getCoord(addressString: addressTextField.text ?? "") { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            print(placemarks ?? "")
            self.placemarksResuts = placemarks
            self.addressTableView.reloadData()
        }
    }
}

extension MainVCSinceIOS90: UITextFieldDelegate {
    //hide keyboard by press ENter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//MARK: get coordintaes of input address
extension MainVCSinceIOS90 {
    func getCoord(addressString:String,
                   completionHandler: @escaping([CLPlacemark]?, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                completionHandler(placemarks, nil)
                return
            }
            completionHandler(nil, error as NSError?)
        }
    }
}


//MARK: Table
extension MainVCSinceIOS90: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placemarksResuts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let searchResult = placemarksResuts?[indexPath.row] {
            let cell = addressTableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapPointCell
            
            cell.configurePM(result: searchResult)
            //cell.pointTitle.text = searchResult.name
            //cell.pointSubtitle.text = searchResult.subAdministrativeArea
            
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Segues.showRoute.rawValue, sender: placemarksResuts?[indexPath.row].location?.coordinate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showRoute.rawValue, let routeVC = segue.destination as? RouteMapVC {
            if let c = sender as? CLLocationCoordinate2D {
                routeVC.passedCoordinate = c
            }
        }
    }
    
}




