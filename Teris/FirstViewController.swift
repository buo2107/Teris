//
//  FirstViewController.swift
//  Teris
//
//  Created by User23 on 2019/1/4.
//  Copyright © 2019 User21. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {

    @IBOutlet weak var playButtion: UIButton!
    var audio: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // 將 navigation bar 變透明
        let image = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.shadowImage = image
        
        do{
            let url = Bundle.main.url(forResource: "Sounds/New Super Mario Bros - OverWorld", withExtension:"mp3")
            audio = try AVAudioPlayer(contentsOf: url!)
            audio?.prepareToPlay()
        } catch {
            print("Error")
        }
        audio?.play()
    }
    
    @IBAction func startGame(_ sender: Any) {
        audio?.stop()
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
