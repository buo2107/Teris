//
//  SoundManager.swift
//  Teris
//
//  Created by User23 on 2019/1/6.
//  Copyright © 2019 User21. All rights reserved.
//

import SpriteKit
//引入多媒体框架
import AVFoundation

class SoundManager: SKNode {

    //申明一个播放器
    var bgMusicPlayer = AVAudioPlayer()
    //播放点击的动作音效
    //let hitAct = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
    
    //播放背景音乐的音效
    func playBackGround(_ source:String){
        print("開始播放音樂!")
        //获取bg.mp3文件地址
        let bgMusicURL =  Bundle.main.url(forResource: source, withExtension: "mp3")!
        //根据背景音乐地址生成播放器
        try! bgMusicPlayer = AVAudioPlayer (contentsOf: bgMusicURL)
        //设置为循环播放(
        bgMusicPlayer.numberOfLoops = -1
        //准备播放音乐
        bgMusicPlayer.prepareToPlay()
        //播放音乐
        bgMusicPlayer.play()
    }
    
    func musicStop() {
        bgMusicPlayer.stop()
    }

}
