//
//  CanvasViewController.swift
//  Zippy Contact
//
//  Created by Steven Hurtado on 1/19/18.
//  Copyright © 2018 Steven Hurtado. All rights reserved.
//

import UIKit

class Candidate {
    var givenName : String?
    var familyName : String?
    var number : String?
    
    init(given: String, fam: String, num: String) {
        self.givenName = given
        self.familyName = fam
        self.number = num
    }
    
    func contact() {
        guard let tel = self.number else {return}
        print("tried to call : \(tel)")
        if let url = URL(string: "tel://\(tel)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print(url)
        }
    }
}

class CanvasViewController: UIViewController {

    private var lastPoint : CGPoint = CGPoint()
    private var intialPoint : CGPoint = CGPoint()
    private var swiped = false
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var settingsBtn: UIButton!
    
    var activityIndicator = UIActivityIndicatorView()
    
    //per type
    var training = false
    var trainingCount = 1
    var trainingCandidate : Candidate?
    var trainingSet : [[CGPoint]] = []
    @IBOutlet weak var closeBtn: UIButton!
    
    private var localPoints : [CGPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpView() {
        self.navigationController?.isNavigationBarHidden = true
        
        countLabel.isHidden = !training
        closeBtn.isHidden = !training
        settingsBtn.isHidden = training
        
        if training {
            self.countLabel.text = "\(trainingCount)/5"
        }
        
        self.backView.layer.shadowColor = UIColor.black.cgColor
        self.backView.layer.shadowOpacity = 0.48
        self.backView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        self.backView.layer.shadowRadius = 10
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
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
            let currentPoint = touch.location(in: self.imgView)
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
        let defaults = UserDefaults.standard
        print("Local: \(self.localPoints)\n")
        if training {
            trainingCount = trainingCount + 1
            self.trainingSet.append(self.localPoints)
            
            if(trainingCount - 1 == 5) {
//                activityIndicator.startAnimating()
                
                // add to default
                if let candidate = trainingCandidate, let given = candidate.givenName,
                    let fam = candidate.familyName, let num = candidate.number {
                    let key = "\(given) \(fam)"
                    
                    //individual
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.trainingSet)
                    defaults.set(encodedData, forKey: "\(key) Set")
                    defaults.set(num, forKey: "\(key) Number")
                    
                    //mass
                    if var massArr = defaults.object(forKey: "TrainingSet") as? [String] {
                        massArr.append(key)
                        defaults.set(massArr, forKey: "TrainingSet")
                    } // not there lets create
                    else {
                        var massArr : [String] = []
                        massArr.append(key)
                        defaults.set(massArr, forKey: "TrainingSet")
                    }
                }
                
                self.dismiss(animated: true, completion: nil)
            }
            self.countLabel.text = "\(trainingCount)/5"
        } else {
            //get entire training set
            if let massArr = defaults.object(forKey: "TrainingSet") as? [String] {
                print("\nMASS: \(massArr)\n")
                
                for key in massArr {
                    if let decoded = defaults.object(forKey: "\(key) Set") as? Data, let set = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [[CGPoint]] {
                        print("SET: \(set)")
                    }
                }
            }
            
            //use our local points to compare
            
            //with decision, if valid call contact
        }
        
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
    
    @IBAction func closeTraining(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

