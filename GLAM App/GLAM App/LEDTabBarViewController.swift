//
//  LEDTabBarViewController.swift
//  GLAM App
//
//  Created by Maddie Min on 3/16/21.
//

import Foundation
import UIKit

class LEDTabBarViewController: UITabBarController {

    @IBOutlet weak var powerButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func powerButtonClicked(_ sender: Any) {
        Services.power()
    }
}
