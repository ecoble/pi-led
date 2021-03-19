//
//  PatternViewController.swift
//  GLAM App
//
//  Created by Maddie Min on 3/12/21.
//

import Foundation
import UIKit

class PatternViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        table.layer.masksToBounds = true
        table.layer.borderColor = UIColor.separator.cgColor
        table.layer.borderWidth = 1.0
        table.layer.cornerRadius = 12.0
        table.layoutMargins = UIEdgeInsets.zero
        table.separatorInset = UIEdgeInsets.zero

        self.navigationController?.navigationBar.backItem?.title = "Home"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        switch indexPath.row {
        case 0:
            Services.changePattern(pattern: "auto")
        case 1:
            Services.changePattern(pattern: "flash")
        case 2:
            Services.changePattern(pattern: "jump3")
        case 3: 
            Services.changePattern(pattern: "fade3")
        case 4:
            Services.changePattern(pattern: "jump7")
        case 5:
            Services.changePattern(pattern: "fade7")
        case 6:
            Services.changePattern(pattern: "red")
        default:
            print("Error: cell out of bounds")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "patternCell", for: indexPath) as! PatternCell

        switch indexPath.row {
        case 0:
            cell.patternLabel.text = "Auto"
        case 1:
            cell.patternLabel.text = "Flash"
        case 2:
            cell.patternLabel.text = "Jump 3"
        case 3:
            cell.patternLabel.text = "Fade 3"
        case 4:
            cell.patternLabel.text = "Jump 7"
        case 5:
            cell.patternLabel.text = "Fade 7"
        case 6:
            cell.patternLabel.text = "Red"
        default:
            print("Error: cell out of bounds")
        }
    
        return cell
        
    }
}
