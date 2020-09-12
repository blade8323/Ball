//
//  BallView.swift
//  Ball
//
//  Created by Владислав Соколов on 12.09.2020.
//  Copyright © 2020 Владислав Соколов. All rights reserved.
//

import UIKit
import CoreMotion

class BallView: UIView {
    
    var acceleration = CMAcceleration(x: 0, y: 0, z: 0)
    private let image = UIImage(named: "ball")!
    private var currentpoint: CGPoint = CGPoint.zero {
        didSet {
            var newX = currentpoint.x
            var newY = currentpoint.y
            if newX < 0 {
                newX = 0
                ballXVelocity =  -(ballXVelocity / 2.0)
            } else if newX > bounds.size.width - image.size.width {
                newX = bounds.size.width - image.size.width
                ballXVelocity = -(ballXVelocity / 2.0)
            }
            if newY < 0 {
                newY = 0
                ballYVelocity = -(ballYVelocity / 2.0)
            } else if newY > bounds.size.height - image.size.height {
                newY = bounds.size.height - image.size.height
                ballYVelocity = -(ballYVelocity / 2.0)
            }
            currentpoint = CGPoint(x: newX, y: newY)
            
            let currentRect = CGRect(x: newX, y: newY, width: newX + image.size.width, height: newY + image.size.height)
            let prevRect = CGRect(x: oldValue.x, y: oldValue.y, width: oldValue.x + image.size.width, height: oldValue.y + image.size.height)
            setNeedsDisplay(currentRect.union(prevRect))
        }
    }
    private var ballXVelocity = 0.0
    private var ballYVelocity = 0.0
    private var lastUpdateTime = Date()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        currentpoint = CGPoint(x: (bounds.size.width / 2.0) +  (image.size.width / 2.0), y: (bounds.size.height / 2.0) +  (image.size.height / 2.0))
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
        image.draw(at: currentpoint)
    }
    
    func update() {
        let now = Date()
        let secondsSinseLastDraw = now.timeIntervalSince(lastUpdateTime)
        ballXVelocity = ballXVelocity + (acceleration.x * secondsSinseLastDraw)
        ballYVelocity = ballYVelocity + (acceleration.y * secondsSinseLastDraw)
        
        let xDelta = secondsSinseLastDraw * ballXVelocity * 500
        let yDelta = secondsSinseLastDraw * ballYVelocity * 500
        currentpoint = CGPoint(x: currentpoint.x + CGFloat(xDelta), y: currentpoint.y + CGFloat(yDelta))
        lastUpdateTime = now
    }

}
