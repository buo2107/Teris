//
//  SettingsViewController.swift
//  Teris
//
//  Created by User23 on 2019/1/5.
//  Copyright © 2019 User21. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var BGMmenuButton: UIButton!
    @IBOutlet weak var soundEffectMenuButton: UIButton!
    @IBOutlet var BGMArray: [UIButton]!
    @IBOutlet var SoundEffectArray: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        soundEffectMenuButton.frame = CGRect(x: 0, y: 121, width: 320, height: 55)
        for i in 0...2 {
            SoundEffectArray[i].frame = CGRect(x: 0, y: 121+57+(44*i), width: 320, height: 55)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openBGMMenu(_ sender: Any) {
        BGMArray.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
                })
        }
        if BGMArray[0].isHidden {
            soundEffectMenuButton.frame = CGRect(x: 0, y: BGMArray[0].frame.origin.y, width: 320, height: 55)
        }
        else {
            soundEffectMenuButton.frame = CGRect(x: 0, y: BGMArray[2].frame.origin.y+46, width: 320, height: 55)
        }
    }
    
    @IBAction func openSoundEffectMenu(_ sender: Any) {
        SoundEffectArray.forEach { (view) in
            UIView.animate(withDuration: 0.3, animations: {
                view.isHidden = !view.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
