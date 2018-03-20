// Created by: laserman at stackoverflow

import PlaygroundSupport
import UIKit
import SpriteKit


class MusicBoard: SKSpriteNode {
    
    var defaultTexture:SKTexture
    var btnSet:[FTButtonNode] = []
    var musicSet:[String] = []
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(normalTexture defaultTexture: SKTexture!, selectedTexture:SKTexture!, disabledTexture: SKTexture?, width:Float, height:Float) {
        
        self.defaultTexture = defaultTexture
        
        super.init(texture: defaultTexture, color: UIColor.white, size: defaultTexture.size())
        isUserInteractionEnabled = true
        
        //Creating and adding a blank label, centered on the button
        self.size = CGSize(width: CGFloat(width), height: CGFloat(height))
        
        
        // Adding this node as an empty layer. Without it the touch functions are not being called
        // The reason for this is unknown when this was implemented...?
        //        let bugFixLayerNode = SKSpriteNode(texture: nil, color: UIColor.clear, size: defaultTexture.size())
        let bugFixLayerNode = SKSpriteNode(texture: nil, color: UIColor.clear, size: self.size)
        bugFixLayerNode.position = self.position
        addChild(bugFixLayerNode)
        
        
        // Adding borders
        let tile = SKShapeNode(rect: CGRect(x: CGFloat(-width/2.0), y: CGFloat(-height/2.0), width: CGFloat(width), height: CGFloat(height)), cornerRadius: 0)
        tile.strokeColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        tile.lineWidth = 5
        addChild(tile)
    }
    
    func addButtons(_ num:Int) {
      for n in 1...7 {
        musicSet.append(String(n))
      }
      
//        var xorigin = -self.frame.origin.x
//        let yorigin = -self.frame.origin.y
//        var xorigin:CGFloat = self.frame.origin.x/2
      let yorigin:CGFloat = 0
      let baseDiff = 0.5
      let step = self.frame.width/CGFloat(num) - CGFloat(Double(num)*baseDiff)
      
      var xorigin:CGFloat = -self.frame.width/2 + step/2
      print(xorigin)
      print(self.frame.origin)
      print(step)
      
      for i in 1...num {
        // Generate the Button nodes
        let bt_w:Float = Float(step)
        let bt_h:Float = Float(self.frame.height) - 5
        let buttonTexture: SKTexture! = SKTexture(imageNamed: "white")
        let buttonTextureSelected: SKTexture! = SKTexture(imageNamed: "white")
        let button = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture, width: bt_w, height: bt_h)
//        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(buttonTap))
//        button.setButtonAction(target: self, triggerEvent: .TouchDown, action: #selector(buttonTap))
//        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(FTButtonNode.addSong))
        button.setSong(musicSet[i])
        
        button.position = CGPoint(x: xorigin,y: yorigin)
      
        button.zPosition = self.zPosition + 1
//            button.size = CGSize(width: 50, height: 50)
//            button.size = CGSize(width: step, height: self.frame.height - 5)
      
        button.name = "Button"
        self.addChild(button)
        self.btnSet.append(button)
      
        xorigin += CGFloat(step) + CGFloat(baseDiff)
      }
    }
    
    // Handle Button
    @objc func buttonTap() {
      print("Button pressed")
      let parentNode = self.parent as! GameScene
      
      print(parentNode)
      parentNode.insertFromChild()
      
      
//        parent.addChild()
    }
    
    
}

