//
//  GameViewController.swift
//  Teris
//
//  Created by User21 on 2018/12/13.
//  Copyright © 2018 User21. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {

    var scene: GameScene!
    var swiftris: Swiftris!
    
    var panPointReference:CGPoint?
    
    lazy var sound = SoundManager()
    
    var grade = [Grade]()
    var dateString: String!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide the navigation back button
        navigationItem.hidesBackButton = true
        // Configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        // Present the scene
        skView.presentScene(scene)
        
        // 獲取當前時間
        let now: Date = Date()
        // 建立時間格式
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd HH:mm:ss"
        // 將當下時間換成設定的時間格式
        dateString = dateFormat.string(from: now)
        
        // 加入背景音樂
        scene.addChild(sound)
        sound.playBackGround("Sounds/Level1")
        
        
        
        //UserDefaults.standard.removeObject(forKey: "grades")
        grade = Grade.read()!
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translation(in: self.view)
        if let originalPoint = panPointReference {
        
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                
                if sender.velocity(in: self.view).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .began {
            panPointReference = currentPoint
        }
    }
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        swiftris.dropShape()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer { if (otherGestureRecognizer as? UIPanGestureRecognizer) != nil { return false } } else if (gestureRecognizer as? UIPanGestureRecognizer) != nil { if otherGestureRecognizer is UITapGestureRecognizer { return true } }
        return false
        
    }
    
    func didTick() {
        swiftris.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!) {}
        self.scene.movePreviewShape(shape: fallingShape) {
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        
        levelLabel.text = "\(swiftris.level)"
        scoreLabel.text = "\(swiftris.score)"
        scene.tickLengthMillis = TickLengthLevelOne
        
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(shape: swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        scene.playSound(sound: "Sounds/gameover.mp3")
        
        // 紀錄成績
        grade.append(Grade(score: Int(scoreLabel.text!)!, level: Int(levelLabel.text!)!, date: dateString))

        Grade.save(grade: grade)
        
        scene.animateCollapsingLines(linesToRemove: swiftris.removeAllBlocks(), fallenBlocks: swiftris.removeAllBlocks()) {
            // 關掉背景音樂
            self.sound.musicStop()
            // 進入結果頁面
            self.performSegue(withIdentifier: "showResult", sender: GameViewController())
        }
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        // 升級後下落速度加快
        if scene.tickLengthMillis >= 100 {
            scene.tickLengthMillis -= 100
        }
        else if scene.tickLengthMillis > 50 {
            scene.tickLengthMillis -= 25
        }
        scene.playSound(sound: "Sounds/levelup.mp3")
        // 升級後更換背景音樂
        sound.musicStop()
        sound.playBackGround("Sounds/Level"+levelLabel.text!)
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        scene.stopTicking()
        scene.redrawShape(shape: swiftris.fallingShape!) {
            swiftris.letShapeFall()
        }
        scene.playSound(sound: "Sounds/drop.mp3")
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        self.view.isUserInteractionEnabled = false
        
        let removedLines = swiftris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(swiftris.score)"
            scene.animateCollapsingLines(linesToRemove: removedLines.linesRemoved, fallenBlocks: removedLines.fallenBlocks) {
                self.gameShapeDidLand(swiftris: swiftris)
            }
            scene.playSound(sound: "Sounds/bomb.mp3")
        }
        else {
            nextShape()
        }
    } // end gameShapeDidLand()
    
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(shape: swiftris.fallingShape!) {}
    }
    
    @IBAction func unwindSegueReGame(segue: UIStoryboardSegue) {
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as? ResultViewController
        controller?.res_level = levelLabel.text
        controller?.res_score = scoreLabel.text
    }
}
