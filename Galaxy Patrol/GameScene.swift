//
//  GameScene.swift
//  Galaxy Patrol
//
//  Created by Bridget Janicki on 8/5/19.
//  Copyright © 2019 Adam Janicki. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //globals
    var user = SKSpriteNode()
    var totalCoins = 0
    var specialCount = 0
    var lives = 3
    var maxLives = 0
    var coun = 0
    var score = 0
    var coins = 0
    var regCounter = 0
    var explosion = false
    var counter = 0
    var move = true
    var fire = true
    var counter2 = 0
    var operate = 90
    var t1 = 0.15
    var skinSelected = 0
    var userWidth: CGFloat = 65
    var spaceTimer: Timer? = nil
    var enemyTimer: Timer? = nil
    var coinTimer: Timer? = nil
    var Highscore = 0
    var highscorelabel = SKLabelNode()
    var enemyHeight: CGFloat = 27
    var userHeight: CGFloat = 90
    var explosionTimer: Timer? = nil
    var sc = SKLabelNode()
    var interval = 3.0
    var velo = 2.0
    var userVelo = 18
    var shootVelo = 6.0
    var enemyWidth: CGFloat = 55
    var newWave = false
    var heart1 = SKSpriteNode()
    var heart2 = SKSpriteNode()
    var heart3 = SKSpriteNode()
    var rapid = 0
    var coins2x = 0
     var score2x = 0
    var background = SKSpriteNode()
    override func didMove(to view: SKView) {
        background = self.childNode(withName: "background") as! SKSpriteNode
        heart1 = self.childNode(withName: "heart1") as! SKSpriteNode
        heart2 = self.childNode(withName: "heart2") as! SKSpriteNode
        heart3 = self.childNode(withName: "heart3") as! SKSpriteNode
        sc = self.childNode(withName: "sc") as! SKLabelNode
        score2x = UserDefaults.standard.integer(forKey: "score2x")
        if score2x > -1{
            score2x = UserDefaults.standard.integer(forKey: "score2x")
        }
        else{
            score2x=0
            UserDefaults.standard.set(totalCoins, forKey: "score2x")
        }
        Highscore = UserDefaults.standard.integer(forKey: "Highscore")
        if Highscore > -1{
            Highscore = UserDefaults.standard.integer(forKey: "Highscore")
        }
        else{
            Highscore=0
            UserDefaults.standard.set(Highscore, forKey: "Highscore")
        }
        totalCoins = UserDefaults.standard.integer(forKey: "totalCoins")
        if totalCoins > -1{
            totalCoins = UserDefaults.standard.integer(forKey: "totalCoins")
        }
        else{
            totalCoins=0
            UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
        }
        coins2x = UserDefaults.standard.integer(forKey: "coins2x")
        if coins2x > -1{
            coins2x = UserDefaults.standard.integer(forKey: "coins2x")
        }
        else{
            coins2x=0
            UserDefaults.standard.set(coins2x, forKey: "coins2x")
        }
        highscorelabel = self.childNode(withName: "highscorelabel") as! SKLabelNode
        rapid = UserDefaults.standard.integer(forKey: "rapid")
        if rapid > -1{
            rapid = UserDefaults.standard.integer(forKey: "rapid")
        }
        else{
            rapid=0
            UserDefaults.standard.set(rapid, forKey: "rapid")
        }
        highscorelabel.text = "HI:\(Highscore)"
        if rapid == 1{
            userVelo *= 2
            t1 = 0.05
        }
        skinSelected = UserDefaults.standard.integer(forKey: "skinSelected")
        if skinSelected > -1{
            skinSelected = UserDefaults.standard.integer(forKey: "skinSelected")
        }
        else{
            skinSelected = 1
            UserDefaults.standard.set(skinSelected, forKey: "skinSelected")
        }
        if skinSelected == 2{
            //anakin, vulture droid, coruscant
            enemyWidth = 50
            enemyHeight = 83
            userWidth = 25
        }
        else if skinSelected == 3{
            enemyWidth = 65
            enemyHeight = 56
            userWidth = 80
            userHeight = 63
        }
        else if skinSelected == 4{
            userHeight = 125
            userWidth = 35
            enemyHeight = 80
            enemyWidth = 50
        }
        
        user = self.childNode(withName: "user") as! SKSpriteNode
        user.texture = SKTexture(imageNamed: "user\(skinSelected)")
        user.size = user.texture!.size()
        background.texture = SKTexture(imageNamed: "background\(skinSelected)")
        spaceTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(GameScene.createSpace), userInfo: nil, repeats: true)
        enemyTimer = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(GameScene.createEnemy), userInfo: nil, repeats: true)
        coinTimer = Timer.scheduledTimer(timeInterval: TimeInterval(15.0), target: self, selector: #selector(GameScene.spawnCoin), userInfo: nil, repeats: true)
        maxLives = lives
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if touchLocation.y > -400 && fire == true{
                //shoot
                createLaser()
                counter2=0
                fire=false
            }
            if touchLocation.y < -400 && touchLocation.x > -250 && touchLocation.x < 250{
                user.run(SKAction.moveTo(x: touchLocation.x, duration: t1))
            }
        }
        
        }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if touchLocation.y < -400 && touchLocation.x > -250 && touchLocation.x < 250{
                user.run(SKAction.moveTo(x: touchLocation.x, duration: t1))
            }
        }
    }
    @objc func createSpace(){
        let star = SKShapeNode(rectOf: CGSize(width: Int.random(in: 7..<10), height: Int.random(in: 7..<10)))
        var r = CGFloat.random(in: 0.6..<1)
        var g = CGFloat.random(in: 0.6..<1)
        var b = CGFloat.random(in: 0.6..<1)
        star.strokeColor = SKColor.init(red: r, green: g, blue: b, alpha: 1)
        star.fillColor = SKColor.init(red: r, green: g, blue: b, alpha: 1)
        star.zPosition = 0
        star.name = "star"
        star.position.x = -375 + CGFloat.random(in: 10..<740)
        star.position.y = 667
        addChild(star)
    }
    func createLaser(){
        let laser = SKShapeNode(rectOf: CGSize(width:10, height: 20))
        laser.strokeColor = SKColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        laser.fillColor = SKColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        if skinSelected == 2 || skinSelected == 4{
            laser.strokeColor = SKColor.init(red: 0, green: 1, blue: 0.3, alpha: 1)
            laser.fillColor = SKColor.init(red: 0, green: 1, blue: 0.3, alpha: 1)
        }
        laser.zPosition = 2
        laser.name = "laser"
        laser.position.x = user.position.x
        laser.position.y = user.position.y + 80
        addChild(laser)
    }
    @objc func createEnemy(){
        let enemy: SKSpriteNode!
            var rand = Int.random(in: 1..<6)
            enemy = SKSpriteNode(imageNamed: "spaceship\(rand)")
        enemy.name = "enemy"
        enemy.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        enemy.zPosition = 100
        var rand0 = CGFloat(Int.random(in: 1..<6))
        enemy.position.x = -375 + 125*rand0
        enemy.position.y = 700
        if skinSelected == 2{
            enemy.texture = SKTexture(imageNamed: "enemy2")
            enemy.size = enemy.texture!.size()
        }
        else if skinSelected == 3{
            enemy.texture = SKTexture(imageNamed: "enemy3")
            enemy.size = enemy.texture!.size()
        }
        else if skinSelected == 4{
            enemy.texture = SKTexture(imageNamed: "enemy4")
            enemy.size = enemy.texture!.size()
        }
        addChild(enemy)
    }
    func createLasers(){
        for child in children{
            if child.name == "enemy"{
                var ra = Int.random(in: 1..<3)
                if ra == 1{
                    let lasers = SKShapeNode(rectOf: CGSize(width:10, height: 20))
                    lasers.strokeColor = SKColor.init(red: 0, green: 1, blue: 0.3, alpha: 1)
                    lasers.fillColor = SKColor.init(red: 0, green: 1, blue: 0.3, alpha: 1)
                    if skinSelected == 2 || skinSelected == 4{
                        lasers.strokeColor = SKColor.init(red: 1, green: 0, blue: 0, alpha: 1)
                        lasers.fillColor = SKColor.init(red: 1, green: 0, blue: 0, alpha: 1)
                    }
                    lasers.zPosition = 2
                    lasers.name = "lasers"
                    lasers.position.x = child.position.x
                    lasers.position.y = child.position.y - enemyHeight
                    addChild(lasers)
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        showSpace()
        if lives == maxLives && score % 10 == 0 && score > 0 && newWave == false{
            createNewWave()
            newWave = true
        }
        else if lives == maxLives - 1 && score % 10 == 9 && score > 0 && newWave == false{
            createNewWave()
            newWave = true
        }
        else if lives == maxLives - 2 && score % 10 == 8 && score > 0 && newWave == false{
            createNewWave()
            newWave = true
        }
        showLaser()
        showEnemy()
        if regCounter % 10 == 0{
            moveEnemy()
        }
        if regCounter % operate == 0{
            createLasers()
        }
        showLasers()
        moveCoin()
        checkBottom()
        collisionDetection()
        removeItems()
        specialCount += 1
        if specialCount > 30{
            specialCount = 0
            removeExplosions()
        }
        counter += 1
        if counter > 5 {
            move = true
        }
        counter2+=1
        if counter2 > 12{
            fire = true
        }
        regCounter += 1
    }
    func showSpace(){
        enumerateChildNodes(withName: "star", using: { (star, stop) in
            let starz = star as! SKShapeNode
            starz.position.y -= 5
        })
    }
    @objc func spawnCoin(){
        var rand = CGFloat.random(in: 0..<500)
        let coin: SKSpriteNode!
        coin = SKSpriteNode(imageNamed: "coin48")
        coin.name = "coin"
        coin.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        coin.zPosition = 100
        coin.position.x = -250 + rand
        coin.position.y = 700
        addChild(coin)
    }
    func moveCoin(){
        enumerateChildNodes(withName: "coin", using: { (coin, stop) in
            let coinz = coin as! SKSpriteNode
            coinz.position.y -= 3
        })
    }
    func showLaser(){
        var velocity = CGFloat(userVelo)
        enumerateChildNodes(withName: "laser", using: { (laser, stop) in
            let laserz = laser as! SKShapeNode
            laserz.position.y += velocity
        })
    }
    func showLasers(){
        var velocity = CGFloat(shootVelo)
        enumerateChildNodes(withName: "lasers", using: { (lasers, stop) in
            let lasersz = lasers as! SKShapeNode
            lasersz.position.y -= velocity
        })
    }
    func showEnemy(){
        var velocity = CGFloat(velo)
        enumerateChildNodes(withName: "enemy", using: { (enemy, stop) in
            let enemyz = enemy as! SKSpriteNode
            enemyz.position.y -= velocity
        })
    }
    func showExplosions(){
        enumerateChildNodes(withName: "explosion", using: { (explosion, stop) in
            let explosionz = explosion as! SKSpriteNode
            explosionz.position.y -= 2.1
        })
    }
    func checkBottom(){
        for child in children{
            if child.name == "enemy" && child.position.y + 30 < -667{
                lives -= 1
                child.position.x = -1000
                child.position.y = -1000
                checkLives()
            }
        }
    }
    func collisionDetection(){
        //shots v enemies
        //enemies v spaceship
        for child in children{
            var hit = false
            var xp: CGFloat = 0
            var yp: CGFloat = 0
            if child.name == "laser"{
                var x = child.position.x
                var y = child.position.y
                for child in children{
                    if child.name == "enemy" && x > child.position.x - enemyWidth && x < child.position.x + enemyWidth && y > child.position.y - enemyHeight && y < child.position.y + enemyHeight{
                        hit = true
                        xp = child.position.x
                        yp = child.position.y
                        let explosionPic: SKSpriteNode!
                        explosionPic = SKSpriteNode(imageNamed: "explosion")
                        explosionPic.name = "explosion"
                        explosionPic.zPosition = 100
                        explosionPic.position.x = xp
                        explosionPic.position.y = yp
                        addChild(explosionPic)
                        child.position.x = -1000
                        child.position.y = -1000
                        newWave = false
                        score += 1
                        if score2x == 1{
                            score += 1
                        }
                        sc.text = "SC:\(score) C:\(coins)"
                    }
                }
                if hit == true{
                    child.position.x = -10000
                    child.position.y = 100000
                }
            }
        }
        //coins
        for child in children{
            if child.name == "coin"{
                if child.position.x + 24 > user.position.x - userWidth && child.position.x - 24 < user.position.x + userWidth && child.position.y + 24 > user.position.y - userHeight && child.position.y - 24 < user.position.y + userHeight{
                    coins += 1
                    if coins2x == 1{
                        coins += 1
                    }
                    child.position.x = -600
                    child.position.y = -1000
                    sc.text = "SC:\(score) C:\(coins)"
                }

            }
        }
        for child in children{
            if child.name == "lasers"{
                var x = child.position.x
                var y = child.position.y
                if x > user.position.x - userWidth && x < user.position.x + userWidth && y > user.position.y - userHeight && y <  user.position.y + userHeight{
                    //you got hit
                    lives-=1
                    checkLives()
                    child.position.x = -1000
                    child.position.y = -1000
                    if explosion == false{
                        explosion = true
                        explosionTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.19), target: self, selector: #selector(GameScene.switchImage), userInfo: nil, repeats: true)
                    }
                }
            }
        }
        for child in children{
            if child.name == "enemy" && child.position.y - enemyHeight + 10 < user.position.y + userHeight && child.position.y + enemyHeight - 10 > user.position.y - userHeight && child.position.x - enemyWidth < user.position.x + userWidth && child.position.x + enemyWidth > user.position.x - userWidth{
                child.position.x = -1000
                if explosion == false{
                    lives -= 1
                    explosion = true
                    explosionTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.19), target: self, selector: #selector(GameScene.switchImage), userInfo: nil, repeats: true)
                   checkLives()
                }
                
            }
        }
        
    }
    func endGame(){
        UserDefaults.standard.set(0, forKey: "rapid")
        UserDefaults.standard.set(0, forKey: "coins2x")
        UserDefaults.standard.set(0, forKey: "score2x")
        if score > Highscore{
            Highscore = score
            UserDefaults.standard.set(Highscore, forKey: "Highscore")
        }
        totalCoins += coins
        UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
        let menuScene = SKScene(fileNamed: "GameMenu")!
        menuScene.scaleMode = .aspectFill
        view?.presentScene(menuScene, transition: SKTransition.doorsCloseHorizontal(withDuration: TimeInterval(1.2)))
    }
    @objc func switchImage(){
        if coun % 2 == 0{
            user.texture = SKTexture(imageNamed: "explosion")
        }
        else{
            user.texture = SKTexture(imageNamed: "user\(skinSelected)")
        }
        coun+=1
        if(coun == 8){
            explosionTimer?.invalidate()
            explosionTimer = nil
            explosion = false
            coun = 0
        }
    }
    func removeExplosions(){
        for child in children{
            if child.name == "explosion"{
                child.removeFromParent()
                break
            }
        }
    }
    func removeItems(){
        for child in children{
            if child.position.y < -720 || child.position.y > 710{
                child.removeFromParent()
            }
        }
    }
    func checkLives(){
        if lives == 2{
            heart3.position.y = 1000
        }
        else if lives == 1{
            heart2.position.y = 1000
        }
        else if lives == 0{
            heart1.position.y = 1000
            endGame()
        }
    }
    func createNewWave(){
        enemyTimer?.invalidate()
        enemyTimer = nil
        if interval > 0.8{
             interval -= 0.2
        }
        if operate > 30{
            operate -= 10
        }
        velo += 0.8
        shootVelo += 0.5
        enemyTimer = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(GameScene.createEnemy), userInfo: nil, repeats: true)
    }
    func moveEnemy(){
        for child in children{
            if child.name == "enemy"{
                var rand = Int.random(in: 4..<10)
                var de = Int.random(in: 1..<3)
                if de == 1{
                    if child.position.x + CGFloat(rand) < 250{
                        child.position.x += CGFloat(rand)
                    }
                }
                else if de == 2{
                    if child.position.x - CGFloat(rand) > -250{
                        child.position.x -= CGFloat(rand)
                    }
                }
            }
        }
    }
}

