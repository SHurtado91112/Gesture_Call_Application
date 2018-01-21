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
    private var intialPoint : CGPoint = CGPoint()
    private var swiped = false
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    private var localPoints : [CGPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpView() {
        self.backView.layer.shadowColor = UIColor.black.cgColor
        self.backView.layer.shadowOpacity = 0.48
        self.backView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        self.backView.layer.shadowRadius = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            self.lastPoint = touch.location(in: self.imgView)
            self.intialPoint = self.lastPoint
            self.localPoints.append(Util.zeroPoint(point: self.lastPoint, offset: self.intialPoint))
        }
    }
    
    func drawLines(from: CGPoint, to: CGPoint) {
        UIGraphicsBeginImageContext(self.imgView.frame.size)
        self.imgView.image?.draw(in: CGRect(x: 0, y: 0, width: self.imgView.frame.width, height: self.imgView.frame.height))
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
            var currentPoint = touch.location(in: self.imgView)
            drawLines(from: self.lastPoint, to: currentPoint)
            self.lastPoint = currentPoint
            self.localPoints.append(Util.zeroPoint(point: self.lastPoint, offset: self.intialPoint))
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(from: lastPoint, to: lastPoint)
            self.localPoints.append(Util.zeroPoint(point: self.lastPoint, offset: self.intialPoint))
        }
        
//        Util.saveImage(img: self.imgView.image)
        print("\(self.localPoints)\n")
        self.localPoints = []
        self.clearCanvas()
    }
    
    func clearCanvas() {
        self.imgView.alpha = 1.0
        UIView.animate(withDuration: 0.48, animations: {
            self.imgView.alpha = 0.0
        }) { (end) in
            self.imgView.image = UIImage()
            UIView.animate(withDuration: 0.48, animations: {
                self.imgView.alpha = 1.0
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

