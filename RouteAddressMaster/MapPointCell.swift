//
//  MapPointCell.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/8/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit
import MapKit


class MapPointCell: UITableViewCell {

    @IBOutlet weak var pointImg: UIImageView!
    @IBOutlet weak var pointTitle: UILabel!
    @IBOutlet weak var pointSubtitle: UILabel!
    
    override func awakeFromNib() {
        self.dropShadow()
    }
    
    @available(iOS 9.3, *)
    func configureLS(result: MKLocalSearchCompletion) {
        pointTitle.text = result.title
        pointSubtitle.text = result.subtitle
        
    }
    func configurePM(result: CLPlacemark) {
        pointTitle.text = result.name
        pointSubtitle.text = result.administrativeArea
        
    }
    
    

}
