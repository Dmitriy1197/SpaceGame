//
//  CGFloat Exts.swift
//  SpaceGame iOS
//
//  Created by Dima on 14.02.2024.
//

import CoreGraphics
extension CGFloat{
    static func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    static func random(min: CGFloat, max: CGFloat) ->CGFloat{
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}
