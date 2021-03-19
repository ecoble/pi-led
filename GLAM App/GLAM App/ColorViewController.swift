//
//  ColorViewController.swift
//  GLAM App
//
//  Created by Maddie Min on 3/12/21.
//

import Foundation
import UIKit

class ColorViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var editColorButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    private var selectedColor = UIColor.systemTeal
    private var colorPicker = UIColorPickerViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        colorButton.backgroundColor = self.selectedColor
        colorButton.layer.cornerRadius = 20.0
        editColorButton.layer.cornerRadius = 9.0
        editColorButton.layer.borderWidth = 0.5
        editColorButton.layer.borderColor = UIColor.black.cgColor
        
        self.navigationController?.navigationBar.backItem?.title = "Home"
        self.navigationController?.navigationItem.title = "LEDs"
        self.navigationItem.title = "LEDs"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let r = CGFloat(Double(UserDefaults.standard.string(forKey: "red") ?? "0") ?? 0)
        let g = CGFloat(Double(UserDefaults.standard.string(forKey: "green") ?? "0") ?? 0)
        let b = CGFloat(Double(UserDefaults.standard.string(forKey: "blue") ?? "0") ?? 0)
        let a = CGFloat(Double(UserDefaults.standard.string(forKey: "alpha") ?? "0") ?? 0)
        self.selectedColor = UIColor(red: r, green: g, blue: b, alpha: a)
        colorButton.backgroundColor = self.selectedColor
        
    }
    
    @IBAction func pickColor(_ sender: Any) {
        
        colorPicker.supportsAlpha = true
        colorPicker.selectedColor = selectedColor
        colorPicker.delegate = self
        present(colorPicker, animated: true)
        
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        
        self.selectedColor = viewController.selectedColor
        self.colorButton.backgroundColor = viewController.selectedColor
        
        let components = self.selectedColor.cgColor.components
        let red = abs(Int((components?[0] ?? 0) * 255.0))
        let green = abs(Int((components?[1] ?? 0) * 255.0))
        let blue = abs(Int((components?[2] ?? 0) * 255.0))
        let alpha = Int((components?[3] ?? 0) * 255.0)
        
        // get abs values
        let defaults = UserDefaults.standard
        defaults.set(red, forKey: "red")
        defaults.set(green, forKey: "green")
        defaults.set(blue, forKey: "blue")
        defaults.set(alpha, forKey: "alpha")
        
        Services.setColor(red: red, green: green, blue: blue)
        dismiss(animated: true, completion: nil)
        
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController){
        
        self.selectedColor = viewController.selectedColor
        
    }
}
