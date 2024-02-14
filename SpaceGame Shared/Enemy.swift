//
//  Enemy.swift
//  SpaceGame iOS
//
//  Created by Dima on 14.02.2024.
//

import SpriteKit

enum EnemySettings: Int{
    case small = 0, medium, large
}
class Enemy: SKSpriteNode {
    var health: Int = 5
    var type: EnemySettings = .small
    var scoreValue: Int = 1
    
    class func createEnemy(imageNamed: String, health: Int, scale: CGFloat, scoreValue: Int) -> Enemy {
        let enemy = Enemy(imageNamed: imageNamed)
        enemy.health = health
        enemy.zPosition = 1
        enemy.setScale(scale)
        enemy.setupPhysics()
        return enemy
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = PhysicsCategory.enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.player
        physicsBody?.collisionBitMask = PhysicsCategory.player
    }
    
    class func createEnemySmall() -> Enemy {
        return createEnemy(imageNamed: "enemy1", health: 2, scale: 3, scoreValue: 1)
    }
    
    class func createEnemyMedium() -> Enemy {
        return createEnemy(imageNamed: "enemy2", health: 3, scale: 2, scoreValue: 1)
    }
    
    class func createEnemyLarge() -> Enemy {
        return createEnemy(imageNamed: "enemy3", health: 5, scale: 2, scoreValue: 1)
    }
}
