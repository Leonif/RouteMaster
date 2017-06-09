//
//  MainVC.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/8/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit
import MapKit


class MainVCSinceIOS93: UIViewController  {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var backImg: UIImageView!
    var searchResults = [MKLocalSearchCompletion]()
    var searchCompleter = MKLocalSearchCompleter()

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
        addressTextField.delegate = self
    }
    @IBAction func addressChanged(_ sender: Any) {
        print(addressTextField.text ?? "")
        searchCompleter.queryFragment = addressTextField.text ?? ""
    }
}


extension MainVCSinceIOS93: UITextFieldDelegate {
    //hide keyboard by press ENter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//MARK: Table
extension MainVCSinceIOS93: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
            if let cell = addressTableView.dequeueReusableCell(withIdentifier: "MapCell") as? MapPointCell {
            cell.pointTitle.text = searchResult.title
            
            cell.pointSubtitle.text = searchResult.subtitle
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showRoute.rawValue, let routeVC = segue.destination as? RouteMapVC {
            if let c = sender as? CLLocationCoordinate2D {
                routeVC.passedCoordinate = c
            }
        }
    }
    
}


//MARK: Autocomplete
extension MainVCSinceIOS93: MKLocalSearchCompleterDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let completion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            print(String(describing: coordinate))
            self.performSegue(withIdentifier: Segues.showRoute.rawValue, sender: coordinate)
        }
    }

    
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        addressTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
        
    }
}

