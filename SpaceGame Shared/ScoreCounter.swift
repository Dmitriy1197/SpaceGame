//
//  ScoreCounter.swift
//  SpaceGame iOS
//
//  Created by Dima on 14.02.2024.
//

import SpriteKit

class ScoreLabel: SKLabelNode {
    var score: Int = 0 {
        didSet {
            text = "Score: \(score)"
        }
    }
    
    convenience init(initialScore: Int) {
        self.init()
        score = initialScore
        setupLabel()
    }
    
    private func setupLabel() {
        fontName = "Arial"
        fontSize = 60
        fontColor = SKColor.white
        horizontalAlignmentMode = .center
        verticalAlignmentMode = .top
        position = CGPoint(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height )
    }
}
