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
        return
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
//    static func kthNearestNeighbor(trainingSet : [[CGPoint]], ) {
//
//    }
}
