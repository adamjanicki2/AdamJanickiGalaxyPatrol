//
//  GameStore2.swift
//  Galaxy Patrol
//
//  Created by Bridget Janicki on 8/6/19.
//  Copyright © 2019 Adam Janicki. All rights reserved.
//

import Foundation
import SpriteKit
class GameStore2: SKScene{
    
    //globes
    var buy1 = SKLabelNode()
    var buy2 = SKLabelNode()
    var buy3 = SKLabelNode()
    var coinlabel = SKLabelNode()
    var totalCoins = 0
    var has2 = 0
    var has3 = 0
    var has4 = 0
    var skinSelected = 0
    var backButton = SKLabelNode()
    override func didMove(to view: SKView) {
        buy1 = self.childNode(withName: "buy1") as! SKLabelNode
        buy2 = self.childNode(withName: "buy2") as! SKLabelNode
        buy3 = self.childNode(withName: "buy3") as! SKLabelNode
        coinlabel = self.childNode(withName: "coinlabel") as! SKLabelNode
        backButton = self.childNode(withName: "backButton") as! SKLabelNode
        skinSelected = UserDefaults.standard.integer(forKey: "skinSelected")
        totalCoins = UserDefaults.standard.integer(forKey: "totalCoins")
        if totalCoins > -1{
            totalCoins = UserDefaults.standard.integer(forKey: "totalCoins")
        }
        else{
            totalCoins=0
            UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
        }
        has2 = UserDefaults.standard.integer(forKey: "has2")
        if has2 > -1{
            has2 = UserDefaults.standard.integer(forKey: "has2")
        }
        else{
            has2=0
            UserDefaults.standard.set(totalCoins, forKey: "has2")
        }
        has3 = UserDefaults.standard.integer(forKey: "has3")
        if has3 > -1{
            has3 = UserDefaults.standard.integer(forKey: "has3")
        }
        else{
            has3=0
            UserDefaults.standard.set(totalCoins, forKey: "has3")
        }
        has4 = UserDefaults.standard.integer(forKey: "has4")
        if has4 > -1{
            has4 = UserDefaults.standard.integer(forKey: "has4")
        }
        else{
            has4=0
            UserDefaults.standard.set(totalCoins, forKey: "has4")
        }
        coinlabel.text = "Coins: \(totalCoins)"
        if skinSelected != 2 && has2 == 1{
            buy1.text = "Select"
        }
        if skinSelected == 2 && has2 == 1{
            buy1.text = "Selected"
        }
        if skinSelected != 3 && has3 == 1{
            buy2.text = "Select"
        }
        if skinSelected == 3 && has3 == 1{
            buy2.text = "Selected"
        }
        if skinSelected != 4 && has4 == 1{
            buy3.text = "Select"
        }
        if skinSelected == 4 && has2 == 1{
            buy3.text = "Selected"
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
        let touchLocation = touch.location(in: self)
        if atPoint(touchLocation).name == "backButton"{
            let gameMenu = SKScene(fileNamed: "GameStore")!
            gameMenu.scaleMode = .aspectFill
            view?.presentScene(gameMenu, transition: SKTransition.crossFade(withDuration: TimeInterval(1.0)))
        }
            if atPoint(touchLocation).name == "buy1" && has2 == 1 && skinSelected != 2{
                skinSelected = 2
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                buy1.text = "Selected"
                if has3 == 1{
                    buy2.text = "Select"
                }
                if has3 != 1{
                    buy2.text = "Buy 200C"
                }
                if has4 == 1{
                    buy3.text = "Select"
                }
                if has4 != 1{
                    buy3.text = "Buy 200C"
                }
            }
            else if atPoint(touchLocation).name == "buy1" && skinSelected == 2 && has2 == 1 {
                skinSelected = 1
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                buy1.text = "Select"
            }
            else if atPoint(touchLocation).name == "buy2" && skinSelected == 3 && has3 == 1 {
                skinSelected = 1
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                buy2.text = "Select"
            }
            else if atPoint(touchLocation).name == "buy3" && skinSelected == 4 && has4 == 1 {
                skinSelected = 1
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                buy3.text = "Select"
            }
            else if atPoint(touchLocation).name == "buy2" && has3 == 1 && skinSelected != 3{
                skinSelected = 3
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                buy2.text = "Selected"
                if has2 == 1{
                    buy1.text = "Select"
                }
                if has2 != 1{
                    buy1.text = "Buy 200C"
                }
                if has4 == 1{
                    buy3.text = "Select"
                }
                if has4 != 1{
                    buy3.text = "Buy 200C"
                }
            }
           else if atPoint(touchLocation).name == "buy3" && has4 == 1 && skinSelected != 4{
                skinSelected = 4
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                buy3.text = "Selected"
                if has2 == 1{
                    buy1.text = "Select"
                }
                if has2 != 1{
                    buy1.text = "Buy 200C"
                }
                if has3 == 1{
                    buy2.text = "Select"
                }
                if has3 != 1{
                    buy2.text = "Buy 200C"
                }
            }
            else if atPoint(touchLocation).name == "buy1" && has2 != 1 && skinSelected != 2 && totalCoins > 199{
                totalCoins-=200
                UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
                has2 = 1
                skinSelected = 2
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                UserDefaults.standard.set(has2, forKey: "has2")
                buy1.text = "Selected"
                if has3 == 1{
                    buy2.text = "Select"
                }
                if has3 != 1{
                    buy2.text = "Buy 200C"
                }
                 if has4 == 1{
                    buy3.text = "Select"
                }
                if has4 != 1{
                    buy3.text = "Buy 200C"
                }
                 coinlabel.text = "Coins: \(totalCoins)"
            }
            else if atPoint(touchLocation).name == "buy2" && has3 != 1 && skinSelected != 3 && totalCoins > 199{
                totalCoins-=200
                UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
                has3 = 1
                skinSelected = 3
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                UserDefaults.standard.set(has3, forKey: "has3")
                buy2.text = "Selected"
                if has2 == 1{
                    buy1.text = "Select"
                }
                if has2 != 1{
                    buy1.text = "Buy 200C"
                }
                if has4 == 1{
                    buy3.text = "Select"
                }
                if has4 != 1{
                    buy3.text = "Buy 200C"
                }
                 coinlabel.text = "Coins: \(totalCoins)"
            }
            else if atPoint(touchLocation).name == "buy3" && has4 != 1 && skinSelected != 4 && totalCoins > 199{
                totalCoins-=200
                UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
                has4 = 1
                skinSelected = 4
                UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
                UserDefaults.standard.set(has4, forKey: "has4")
                buy3.text = "Selected"
                if has3 == 1{
                    buy2.text = "Select"
                }
                if has3 != 1{
                    buy2.text = "Buy 200C"
                }
                if has2 == 1{
                    buy1.text = "Select"
                }
                if has2 != 1{
                    buy1.text = "Buy 200C"
                }
                 coinlabel.text = "Coins: \(totalCoins)"
            }
            
        }
    }
}
