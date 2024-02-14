//
//  GameScene.swift
//  SpaceGame Shared
//
//  Created by Dima on 14.02.2024.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
                abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        return scene
    }
    
    let player = Player()
    let scoreLabel = ScoreLabel(initialScore: 0)
    var enemiesCrossed: [SKNode] = []
    let GOScreen = GameOverScreen()
    
    override func didMove(to view: SKView) {
        addChild(scoreLabel)
        createPlayer()
        createEnemy()
        spawnEnemies()
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = false
        
    }
    // MARK: Player
    func createPlayer(){
        if let particles = SKEmitterNode(fileNamed: "Starfield"){
            particles.position = CGPoint(x: 10, y: 700)
            particles.advanceSimulationTime(30)
            particles.zPosition = -1
            addChild(particles)
        }
        player.name = " "
        player.position.y = frame.minY + 300
        addChild(player)
    }
    //MARK: Enemies
    func createEnemy(){
        let enemy : Enemy
        let type: EnemySettings
        let duration: CGFloat
        
        switch Int(arc4random() % 100 ) {
        case 0...60:
            enemy = Enemy.createEnemySmall()
            type = .small
            duration = CGFloat(Float(arc4random() % 3) + 2.0)
        case 61...90:
            enemy = Enemy.createEnemyMedium()
            type = .medium
            duration = CGFloat(Float(arc4random() % 3) + 4.0)
        default:
            enemy = Enemy.createEnemyLarge()
            type = .large
            duration = CGFloat(Float(arc4random() % 3) + 6.0)
        }
        enemy.type = type
        let enemyF = enemy.frame
        let randomX = CGFloat.random(min: frame.minX + enemyF.width / 2, max: frame.maxX - enemyF.width / 2 )
        enemy.position = CGPoint(x: randomX, y: frame.height + enemyF.height/2.0)
        addChild(enemy)
        enemy.name = "enemy"
        let moveTo = SKAction.moveTo(y: frame.minY, duration: TimeInterval(duration))
        enemy.run(.repeatForever(.sequence([moveTo, .removeFromParent()])))
    }
    func spawnEnemies(){
        run(.repeatForever(.sequence(   [
            .wait(forDuration: 2),
            .run {
                [weak self] in
                self?.createEnemy()
            }
        ])))
    }
}
//MARK: Touches
extension GameScene {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let previousTouchLocation = touch.previousLocation(in: self)
        let movementX = touchLocation.x - previousTouchLocation.x
        if movementX > 0 {
            player.position.x += movementX
        } else if movementX < 0 {
            player.position.x += movementX
        }
    }
}
//MARK: Relation
extension GameScene{
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        if bodyA.categoryBitMask == PhysicsCategory.player && bodyB.categoryBitMask == PhysicsCategory.enemy {
            scene?.isPaused = true
            
            GOScreen.showGameOverScreen(scene: self)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if GOScreen.restartButton.contains(location) {
                restartGame()
            }
        }
    }
    func restartGame(){
        GOScreen.gameOverBackground.removeFromParent()
        GOScreen.restartButton.removeFromParent()
        for case let enemy as Enemy in children {
            if enemy.name == "enemy" {
                enemy.removeFromParent()
            }
        }
        scoreLabel.score = 0
        scene?.isPaused = false
    }
}

//MARK: Score
extension GameScene{
    override func update(_ currentTime: TimeInterval) {
        for case let enemy as SKSpriteNode in self.children {
            if enemy.name == "enemy" && enemy.position.y < player.position.y && !enemiesCrossed.contains(enemy) {
                scoreLabel.score += 1
                enemiesCrossed.append(enemy)
            }
        }
    }
}
