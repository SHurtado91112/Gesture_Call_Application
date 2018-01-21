//
//  Util.swift
//  Zippy Contact
//
//  Created by Steven Hurtado on 1/20/18.
//  Copyright © 2018 Steven Hurtado. All rights reserved.
//

import Foundation
import UIKit

class Util {
    
    private static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func zeroPoint(point: CGPoint, offset: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - offset.x, y: point.y - offset.y)
    }
    
    static func saveImage(img: UIImage?) {
        print("SAVE ME")
//        return
        if let image = img {
            if let data = UIImagePNGRepresentation(image) {
                let filename = self.getDocumentsDirectory().appendingPathComponent("copy.png")
                try? data.write(to: filename)
                
            }
        }
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

class Algo {
    
    static func KNN(x : [String], userInput: [CGPoint]) -> String {
        let training_data = x
        let k: Int = 5
        return kthNearestNeighbor(trainingSet: training_data, testingData: userInput, k: k)
    }
    
    static func calcDistForImage(sets: [[CGPoint]], testingData: [CGPoint]) -> CGFloat {
//        sqrt(np.sum(np.square(testing_data-training_data[i,:])))
        var summed : CGFloat = 0.0
        for set in sets {
            let size = set.count > testingData.count ? testingData.count : set.count
            for i in 0...size-1 {
                let test = testingData[i]
                let pnt = set[i]
                let dx = test.x - pnt.x
                let dy = test.y - pnt.y
                let dist = CGFloat(sqrt(powf(Float(dx), 2) + powf(Float(dy), 2)))
                summed = summed + dist
            }
        }
        
        return sqrt(summed)
    }
    
    static func predict(trainingSet : [String], testingData: [CGPoint], k : Int) -> [String] {
        var distances: [(CGFloat,String)] = []
        var votes: [String] = []
        let defaults = UserDefaults.standard
        for trainee in trainingSet {
            if let decoded = defaults.object(forKey: "\(trainee) Set") as? Data,
                let sets = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [[CGPoint]] {
                let distance = calcDistForImage(sets: sets, testingData: testingData)
                distances.append((distance, trainee))
            }
        }
        distances.sort { (a, b) -> Bool in
            return a.0 < b.0
        }
        
        let kMost = k < distances.count ? k : distances.count
        for i in 0...kMost-1 {
            let vote = distances[i].1
            votes.append(vote)
        }
        
        return votes
    }
    
    static func kthNearestNeighbor(trainingSet: [String], testingData: [CGPoint], k: Int) -> String {
        let predictions = predict(trainingSet: trainingSet, testingData: testingData, k: k)
        
        //calc most freq prediction
        var mostFreq = "None"
        var counter : [String: Int] = [:]
        var max = 0
        for predic in predictions {
            print(predic)
            if let val = counter[predic] {
                counter[predic] = val + 1
            }
            else {
                counter[predic] = 1
            }
            
            if let cnt = counter[predic], cnt > max {
                max = cnt
                mostFreq = predic
            }
        }
        
        return mostFreq
    }
}














