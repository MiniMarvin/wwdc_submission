import Foundation

class Utils {
    
    init() {
        
    }
    
    static func random() -> Float {
        return Float(arc4random())/Float(RAND_MAX)
    }
    
    static func random(_ min: Float, _ max: Float) -> Float{
        return min + random()*max
    }
    
    static func random(_ max: Float) -> Float {
        return random()*max
    }
    
}
