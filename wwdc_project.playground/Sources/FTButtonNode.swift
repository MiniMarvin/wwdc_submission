// Created by: laserman at stackoverflow

import PlaygroundSupport
import UIKit
import SpriteKit


class FTButtonNode: SKSpriteNode {
    
    
    // Images
    var disabledTexture: SKTexture?
    var actionTouchUpInside: Selector?
    var actionTouchUp: Selector?
    var actionTouchDown: Selector?
    weak var targetTouchUpInside: AnyObject?
    weak var targetTouchUp: AnyObject?
    weak var targetTouchDown: AnyObject?
    var defaultColor:CGColor
  
    var song:String = ""
    
    
    enum FTButtonActionType: Int {
        case TouchUpInside = 1,
        TouchDown, TouchUp
    }
    
    var isEnabled: Bool = true {
        didSet {
            if (disabledTexture != nil) {
                texture = isEnabled ? defaultTexture : disabledTexture
                //                self.color = isEnabled ? UIColor.white : UIColor.white
            }
        }
    }
    var isSelected: Bool = false {
        didSet {
            texture = isSelected ? selectedTexture : defaultTexture
            //            self.color = isEnabled ? UIColor.gray : UIColor.white
        }
    }
    
    var defaultTexture: SKTexture
    var selectedTexture: SKTexture
    var label: SKLabelNode
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(normalTexture defaultTexture: SKTexture!, selectedTexture:SKTexture!, disabledTexture: SKTexture?, width:Float, height:Float) {
        
        self.defaultTexture = defaultTexture
        self.selectedTexture = selectedTexture
        self.disabledTexture = disabledTexture
        self.label = SKLabelNode(fontNamed: "Helvetica");
        self.defaultColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        super.init(texture: defaultTexture, color: UIColor.white, size: defaultTexture.size())
        isUserInteractionEnabled = true
        
        //Creating and adding a blank label, centered on the button
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
        self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center;
        addChild(self.label)
        
        
        
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
        tile.lineWidth = 2.5
        addChild(tile)
    }
    
    
    init(color: UIColor, width: Float, height: Float) {
        
        self.defaultTexture = SKTexture()
        self.selectedTexture = SKTexture()
        self.disabledTexture = SKTexture()
        self.label = SKLabelNode(fontNamed: "Helvetica");
        
        self.defaultColor = color as! CGColor
        let sz = CGSize(width: CGFloat(width), height: CGFloat(height))
        
        
        super.init(texture: nil, color: color, size: sz)
        isUserInteractionEnabled = true
        
        // Adding this node as an empty layer. Without it the touch functions are not being called
        // The reason for this is unknown when this was implemented...?
        let bugFixLayerNode = SKSpriteNode(texture: nil, color: UIColor.clear, size: sz)
        bugFixLayerNode.position = self.position
        addChild(bugFixLayerNode)
        
        
        
        // Adding borders
        let tile = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), cornerRadius: 0)
        tile.strokeColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        addChild(tile)
      
        // Add function target
        
    }
    
    /**
     * Taking a target object and adding an action that is triggered by a button event.
     */
    func setButtonAction(target: AnyObject, triggerEvent event:FTButtonActionType, action:Selector) {
        
        switch (event) {
        case .TouchUpInside:
            targetTouchUpInside = target
            actionTouchUpInside = action
        case .TouchDown:
            targetTouchDown = target
            actionTouchDown = action
        case .TouchUp:
            targetTouchUp = target
            actionTouchUp = action
        }
        
    }
  
  
  
  public func setSong(_ song:String) {
    self.song = song
  }

  @objc public func addSong() {
    let parentNode = self.parent as! MusicBoard
    let scene = parentNode.parent as! GameScene
    
    let playAndRemove = SKAction.sequence([.playSoundFileNamed(self.song, waitForCompletion: true)])
    scene.run(playAndRemove)
    
    scene.insertFromChild()
      
  }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isEnabled) {
            return
        }
        
        isSelected = true
//        if (targetTouchDown != nil && targetTouchDown!.responds(to: actionTouchDown)) {
//            UIApplication.shared.sendAction(actionTouchDown!, to: targetTouchDown, from: self, for: nil)
//        }
        addSong()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (!isEnabled) {
            return
        }
        
        let touch: AnyObject! = touches.first
        let touchLocation = touch.location(in: parent!)
        
        if (frame.contains(touchLocation)) {
            isSelected = true
        } else {
            isSelected = false
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isEnabled) {
            return
        }
        
        isSelected = false
        
        if (targetTouchUpInside != nil && targetTouchUpInside!.responds(to: actionTouchUpInside!)) {
            let touch: AnyObject! = touches.first
            let touchLocation = touch.location(in: parent!)
            
            if (frame.contains(touchLocation) ) {
                UIApplication.shared.sendAction(actionTouchUpInside!, to: targetTouchUpInside, from: self, for: nil)
            }
            
        }
        
        if (targetTouchUp != nil && targetTouchUp!.responds(to: actionTouchUp!)) {
            UIApplication.shared.sendAction(actionTouchUp!, to: targetTouchUp, from: self, for: nil)
        }
    }
    
}
