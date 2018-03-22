//: A UIKit based Playground for presenting user interface

import Foundation
import UIKit
import SpriteKit
import PlaygroundSupport


// MARK: Views
public class BaseScreen : UIViewController {
    let mCircle = UIView()
    public var sceneView = SKView()
    private var debug = 1
//    var board:MusicBoard = MusicBoard()
    
    
    
    // Load the basic view
    override public func loadView() {
        //        let view = UIView()
        //        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //
        //        self.view = view
        
        if debug == 0 {
            let scene = GameScene(size: CGSize(width: 500, height: 500))
            scene.scaleMode = .aspectFill
            self.sceneView.presentScene(scene)
            self.sceneView.ignoresSiblingOrder = true
            
            self.sceneView.showsFPS = true
            self.sceneView.showsNodeCount = true
            sceneView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else if debug == 1 {
            let scene1 = PresentationScreen(size: CGSize(width: 500, height: 500))
          
            scene1.scaleMode = .aspectFill
            self.sceneView.presentScene(scene1)
            self.sceneView.ignoresSiblingOrder = true
          
            self.sceneView.showsFPS = true
            self.sceneView.showsNodeCount = true
            sceneView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
      
        self.view = sceneView
    }
    
    
    // Generate the circle
    func draw_circle(_ x:Int, _ y:Int, _ color:CGColor) {
        let radius = 15
        self.mCircle.frame = CGRect(x: x - radius, y: y - radius, width: radius*2, height: radius*2)
        self.mCircle.layer.cornerRadius = 15
        self.mCircle.layer.backgroundColor = color
    }
    
//    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//
//        if let touch = touches.first {
//            let position:CGPoint = touch.location(in: self.view)
//
//            let x = Int(position.x)
//            let y = Int(position.y)
//
//
//            draw_circle(x, y, #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
//            let view = self.view
//            view?.addSubview(self.mCircle)
//            self.view = view
//        }
//
//
//    }
//
//    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let position:CGPoint = touch.location(in: self.view)
//
//            let x = Int(position.x)
//            let y = Int(position.y)
//
//            let r = Float(Float(arc4random()%100)/100.0)
//            let g = Float(Float(arc4random()%100)/100.0)
//            let b = Float(Float(arc4random()%100)/100.0)
//            let mcolor:CGColor = #colorLiteral(red: r, green: g, blue: b, alpha: 1)
//            //            draw_circle(x, y, #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
//            draw_circle(x, y, mcolor)
//            let view = self.view
//            view?.addSubview(self.mCircle)
//            self.view = view
//        }
//    }
  
    
//    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let position:CGPoint = touch.location(in: self.view)
//
//            let x = Int(position.x)
//            let y = Int(position.y)
//
//            draw_circle(x, y, #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
//            let view = self.view
//            view?.addSubview(self.mCircle)
//            self.view = view
//        }
//    }
    
}
