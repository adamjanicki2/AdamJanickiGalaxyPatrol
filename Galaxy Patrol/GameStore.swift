//
//  GameStore.swift
//  Galaxy Patrol
//
//  Created by Bridget Janicki on 8/6/19.
//  Copyright © 2019 Adam Janicki. All rights reserved.
//

import Foundation
import SpriteKit
class GameStore: SKScene{
    //globes
    var totalCoins = 0
    var buy1 = SKLabelNode()
    var buy2 = SKLabelNode()
    var buy3 = SKLabelNode()
    var coinlabel = SKLabelNode()
    var backButt = SKLabelNode()
    var score2x = 0
    var rapid = 0
    var coins2x = 0
    var nextButt = SKLabelNode()
    override func didMove(to view: SKView) {
        
        buy1 = self.childNode(withName: "buy1") as! SKLabelNode
        buy2 = self.childNode(withName: "buy2") as! SKLabelNode
        nextButt = self.childNode(withName: "nextButt") as! SKLabelNode
        coins2x = UserDefaults.standard.integer(forKey: "coins2x")
        if coins2x > -1{
            coins2x = UserDefaults.standard.integer(forKey: "coins2x")
        }
        else{
            coins2x=0
            UserDefaults.standard.set(coins2x, forKey: "coins2x")
        }
        buy3 = self.childNode(withName: "buy3") as! SKLabelNode
        backButt = self.childNode(withName: "backButt") as! SKLabelNode
        score2x = UserDefaults.standard.integer(forKey: "score2x")
        if score2x > -1{
            score2x = UserDefaults.standard.integer(forKey: "score2x")
        }
        else{
            score2x=0
            UserDefaults.standard.set(totalCoins, forKey: "score2x")
        }
        coinlabel = self.childNode(withName: "coinlabel") as! SKLabelNode
        rapid = UserDefaults.standard.integer(forKey: "rapid")
        if rapid > -1{
            rapid = UserDefaults.standard.integer(forKey: "rapid")
        }
        else{
            rapid=0
            UserDefaults.standard.set(rapid, forKey: "rapid")
        }
        totalCoins = UserDefaults.standard.integer(forKey: "totalCoins")
        if totalCoins > -1{
            totalCoins = UserDefaults.standard.integer(forKey: "totalCoins")
        }
        else{
            totalCoins=0
            UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
        }
        coinlabel.text = "Coins: \(totalCoins)"
        if rapid == 1{
            buy1.text = "Selected"
        }
        if score2x == 1{
            buy2.text = "Selected"
        }
        if coins2x == 1{
            buy3.text = "Selected"
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if atPoint(touchLocation).name == "backButt"{
                let gameMenu = SKScene(fileNamed: "GameMenu")!
                gameMenu.scaleMode = .aspectFill
                view?.presentScene(gameMenu, transition: SKTransition.doorway(withDuration: TimeInterval(1.0)))
            }
            else if atPoint(touchLocation).name == "nextButt"{
                let gameMenu = SKScene(fileNamed: "GameStore2")!
                gameMenu.scaleMode = .aspectFill
                view?.presentScene(gameMenu, transition: SKTransition.crossFade(withDuration: TimeInterval(1.0)))
            }
           else if atPoint(touchLocation).name == "buy1" && rapid != 1 && totalCoins > 29{
                //powerup1
                rapid = 1
                totalCoins -= 30
                buy1.text = "Selected"
                UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
                UserDefaults.standard.set(rapid, forKey: "rapid")
                 coinlabel.text = "Coins: \(totalCoins)"
            }
            else if atPoint(touchLocation).name == "buy2" && score2x != 1 && totalCoins > 24{
                //powerup2
                score2x = 1
                totalCoins -= 25
                buy2.text = "Selected"
                UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
                UserDefaults.standard.set(score2x, forKey: "score2x")
                coinlabel.text = "Coins: \(totalCoins)"
            }
            else if atPoint(touchLocation).name == "buy3" && coins2x != 1 && totalCoins > 19{
                //powerup3
                coins2x = 1
                totalCoins -= 20
                buy3.text = "Selected"
                UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
                UserDefaults.standard.set(coins2x, forKey: "coins2x")
                 coinlabel.text = "Coins: \(totalCoins)"
            }
        }
    }
}
