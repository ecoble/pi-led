//
//  DeviceViewController.swift
//  GLAM App
//
//  Created by Maddie Min on 3/12/21.
//

import Foundation
import UIKit

class DeviceViewController: UIViewController {
    
    
    @IBOutlet weak var tvButton: UIButton!
    @IBOutlet weak var ledButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let radius = CGFloat(15.0)
        tvButton.layer.cornerRadius = radius
        ledButton.layer.cornerRadius = radius
    }
}
