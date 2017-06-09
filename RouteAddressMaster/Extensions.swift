//
//  Extensions.swift
//  RouteAddressMaster
//
//  Created by Leonid Nifantyev on 6/9/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    func dropShadow() {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 10, height: 6)
        self.layer.shadowRadius = 10
        
    }
    
    
}

