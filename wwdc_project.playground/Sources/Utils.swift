import Foundation
import PlaygroundSupport
import UIKit
import SpriteKit

class Utils {
    
    init() {
        
    }
    
    static func random() -> Float {
        return Float(arc4random()%10000)/Float(10000)
    }
  
    static func random(_ min: CGFloat, _ max: CGFloat) -> CGFloat{
      return min + CGFloat(random())*(max - min)
    }
  
    static func random(_ min: Float, _ max: Float) -> Float{
        return min + random()*max
    }
    
    static func random(_ max: Float) -> Float {
        return random()*max
    }
    
}
