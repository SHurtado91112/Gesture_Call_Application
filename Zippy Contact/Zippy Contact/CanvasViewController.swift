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
        
        self.setUpView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpView() {
        self.imgView.layer.shadowColor = UIColor.black.cgColor
        self.imgView.layer.shadowOpacity = 0.48
        self.imgView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        self.imgView.layer.shadowRadius = 10
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
            context.setLineWidth(14.8)
            
            let color = UIColor(red: 164.0/255.0, green: 176.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor
            context.setStrokeColor(color)
            
            context.setShadow(offset: CGSize.zero, blur: 10, color: color)
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

