//
//  GameMenu.swift
//  Galaxy Patrol
//
//  Created by Bridget Janicki on 8/5/19.
//  Copyright © 2019 Adam Janicki. All rights reserved.
//

import Foundation
import SpriteKit
class GameMenu: SKScene{
    var startbutton = SKLabelNode()
    var store = SKLabelNode()
    var bestScore = SKLabelNode()
    var MenuBackground = SKSpriteNode()
    var Highscore = 0
     var spaceTimer: Timer? = nil
    override func didMove(to view: SKView) {
        //UserDefaults.standard.set(500, forKey: "totalCoins")
        Highscore = UserDefaults.standard.integer(forKey: "Highscore")
        if Highscore > -1{
            Highscore = UserDefaults.standard.integer(forKey: "Highscore")
        }
        else{
            Highscore=0
            UserDefaults.standard.set(Highscore, forKey: "Highscore")
        }
        startbutton = self.childNode(withName: "startbutton") as! SKLabelNode
        store = self.childNode(withName: "store") as! SKLabelNode
        bestScore = self.childNode(withName: "bestScore") as! SKLabelNode
        bestScore.text = "Best: \(Highscore)"
        spaceTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(GameScene.createSpace), userInfo: nil, repeats: true)
    }
    override func update(_ currentTime: TimeInterval) {
        showSpace()
        removeItems()
    }
    @objc func createSpace(){
        let star = SKShapeNode(rectOf: CGSize(width: Int.random(in: 7..<10), height: Int.random(in: 7..<10)))
        var r = CGFloat.random(in: 0.8..<1)
        var g = CGFloat.random(in: 0.8..<1)
        var b = CGFloat.random(in: 0.8..<1)
        star.strokeColor = SKColor.init(red: r, green: g, blue: b, alpha: 1)
        star.fillColor = SKColor.init(red: r, green: g, blue: b, alpha: 1)
        star.zPosition = -10
        star.name = "star"
        star.position.x = -375 + CGFloat.random(in: 10..<740)
        star.position.y = 667
        addChild(star)
    }
    func showSpace(){
        enumerateChildNodes(withName: "star", using: { (star, stop) in
            let starz = star as! SKShapeNode
            starz.position.y -= 5
        })
    }
    func removeItems(){
        for child in children{
            if child.position.y < -690{
                child.removeFromParent()
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if atPoint(touchLocation).name == "startbutton"{
                let gameScene = SKScene(fileNamed: "GameScene")!
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(0.8)))
            }
            if atPoint(touchLocation).name == "store"{
                let gameStore = SKScene(fileNamed: "GameStore")!
                gameStore.scaleMode = .aspectFill
                view?.presentScene(gameStore, transition: SKTransition.doorway(withDuration: TimeInterval(1.0)))
            }
        }
    }
}
