//
//  MainVC.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/8/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var addressTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    @IBAction func addressChanged(_ sender: Any) {
        print(addressTextField.text ?? "")
    }

    @IBAction func addressEdit(_ sender: Any) {
        
        print(addressTextField.text ?? "")
        
    }
    


}

