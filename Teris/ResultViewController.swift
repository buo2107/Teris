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
    var best_level: String?
    var best_score: String?
    
    var str_l: String?
    var str_s: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //str_l = best_level
        //str_s = best_score
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultLevel.text = str_l
        resultScore.text = str_s
    }
 */
    @IBAction func replay(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "GamePage") {
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func GoBack(_ sender: Any) {
        performSegue(withIdentifier: "BackToFirstPage", sender: nil)
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
