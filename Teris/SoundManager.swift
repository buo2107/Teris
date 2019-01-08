//
//  SoundManager.swift
//  Teris
//
//  Created by User23 on 2019/1/6.
//  Copyright © 2019 User21. All rights reserved.
//

import SpriteKit
//引入多媒體框架
import AVFoundation

class SoundManager: SKNode {

    //申明一個播放器
    var bgMusicPlayer = AVAudioPlayer()
    
    //播放背景音樂的音效
    func playBackGround(_ source:String){
        print("開始播放音樂!")
        //獲取bg.mp3文件地址
        let bgMusicURL =  Bundle.main.url(forResource: source, withExtension: "mp3")!
        //根據背景音樂地址生成播放器
        try! bgMusicPlayer = AVAudioPlayer (contentsOf: bgMusicURL)
        //設置為循環播放(
        bgMusicPlayer.numberOfLoops = -1
        //準備播放音樂
        bgMusicPlayer.prepareToPlay()
        //播放音樂
        bgMusicPlayer.play()
    }
    
    func musicStop() {
        bgMusicPlayer.stop()
        print("stop!")
    }

}
