//
//  ResultViewController.swift
//  Teris
//
//  Created by User23 on 2019/1/6.
//  Copyright © 2019 User21. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLevel: UILabel!
    @IBOutlet weak var resultScore: UILabel!
    
    @IBOutlet var bestLevel: UILabel!
    @IBOutlet var bestScore: UILabel!
    
    var res_level: String?
    var res_score: String?
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the navigation back button
        navigationItem.hidesBackButton = true
        
        // 接收GameViewController回傳的值
        resultLevel.text = res_level
        resultScore.text = res_score
        
        bestLevel.text = Grade.MaxLevel()
        bestScore.text = Grade.MaxScore()
        
    }

    @IBAction func replay(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "GamePage") {
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func GoBack(_ sender: Any) {
        performSegue(withIdentifier: "BackToFirstPage", sender: nil)
    }
    
}
