//
//  MainVC.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/8/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit
import MapKit

class MainVC: UIViewController, MKLocalSearchCompleterDelegate {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressTableView: UITableView!
    var searchResults = [MKLocalSearchCompletion]()
    var searchCompleter = MKLocalSearchCompleter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchCompleter.delegate = self
        searchCompleter.queryFragment = addressTextField.text!
        
        
    }
    @IBAction func addressChanged(_ sender: Any) {
        print(addressTextField.text ?? "")
    }

    


}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
}



extension MainVC {
    
    func completerDidUpdateResults(completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(completer: MKLocalSearchCompleter, didFailWithError error: NSError) {
        // handle error
    }
}

