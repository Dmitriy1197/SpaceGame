//
//  Player.swift
//  SpaceGame iOS
//
//  Created by Dima on 14.02.2024.
//

import SpriteKit

class Player: SKSpriteNode{
    init(){
        let texture = SKTexture(imageNamed: "player")
        super.init(texture: texture, color: .clear, size: texture.size())
        zPosition = 1
        setScale(3)
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.enemy
        physicsBody?.collisionBitMask = PhysicsCategory.enemy
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
