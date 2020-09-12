//
//  ViewController.swift
//  Ball
//
//  Created by Владислав Соколов on 12.09.2020.
//  Copyright © 2020 Владислав Соколов. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    private static let updateInterval = 1.0 / 60.0
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        motionManager.startDeviceMotionUpdates(to: queue) { (motionData, error) in
            let ballView = self.view as! BallView
            ballView.acceleration = motionData!.gravity
            DispatchQueue.main.async {
                ballView.update()
            }
        }
    }
}

