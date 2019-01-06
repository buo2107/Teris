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
    
    var level: Int = 1
    var score: Int = 0
    var swiftris: Swiftris!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultScore.text = "\(score)"
        resultLevel.text = "\(level)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
