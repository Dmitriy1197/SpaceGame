//
//  GameOverScreen.swift
//  SpaceGame iOS
//
//  Created by Dima on 14.02.2024.
//

import SpriteKit
class GameOverScreen: SKScene{
    let gameOverBackground = SKSpriteNode(imageNamed: "gameOver")
    let restartButton = SKSpriteNode(imageNamed: "restartButton")
    func showGameOverScreen(scene: SKScene) {
        gameOverBackground.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        gameOverBackground.zPosition = 2
        gameOverBackground.setScale(2)
        scene.addChild(gameOverBackground)

        restartButton.position = CGPoint(x: frame.midX, y: self.frame.midY - gameOverBackground.size.height )
        restartButton.zPosition = 2
        restartButton.name = "restartButton"
        restartButton.setScale(0.5)
        scene.addChild(restartButton)
    }
}
