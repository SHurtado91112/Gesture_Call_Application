//
//  CanvasViewController.swift
//  Zippy Contact
//
//  Created by Steven Hurtado on 1/19/18.
//  Copyright © 2018 Steven Hurtado. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    private var lastPoint : CGPoint = CGPoint()
    private var swiped = false
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            self.lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLines(from: CGPoint, to: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.imgView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        if let context = UIGraphicsGetCurrentContext() {
            context.move(to: CGPoint(x: from.x, y: from.y))
            context.addLine(to: CGPoint(x: to.x, y: to.y))
            
            context.setBlendMode(.colorBurn)
            context.setLineCap(.round)
            context.setLineWidth(4.8)
            context.setStrokeColor(UIColor(red: 164.0/255.0, green: 176.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor)
            context.strokePath()
            
            self.imgView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.swiped = true
        if let touch = touches.first {
            var currentPoint = touch.location(in: self.view)
            drawLines(from: self.lastPoint, to: currentPoint)
            self.lastPoint = currentPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(from: lastPoint, to: lastPoint)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

