import Foundation
import SpriteKit


public class GameScene: SKScene {
    
    
    private var label : SKLabelNode!
    public var spinnyNode : SKShapeNode!
    private var shouldPlay:Bool = false
    let button = SKSpriteNode(imageNamed: "white")
    var addKeyboard:Bool = true
    
    // MARK: Objects
    override public func didMove(to view: SKView) {
//        let w = (size.width + size.height) * 0.05
//
//        spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.5)
//        spinnyNode.lineWidth = 2.5
//
//
//        let fadeAndRemove = SKAction.sequence([
//            .fadeOut(withDuration: 1),
//            .removeFromParent()])
//
//
//        let grow = SKAction.sequence([.scale(by: CGFloat(2), duration: 1)])
//
//
//        spinnyNode.run(.repeatForever(.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//        spinnyNode.run(grow)
//        spinnyNode.run(fadeAndRemove)
        
        insertPulse()
        
        // Generate the Button nodes
        if addKeyboard {
            let bt_w:Float = 50
            let bt_h:Float = 50
            let buttonTexture: SKTexture! = SKTexture(imageNamed: "white")
            let buttonTextureSelected: SKTexture! = SKTexture(imageNamed: "white")
            let button = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture, width: bt_w, height: bt_h)
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(buttonTap))
            button.position = CGPoint(x: self.frame.midX,y: self.frame.midY)
            button.zPosition = 1
            button.size = CGSize(width: 50, height: 50)
            
            button.name = "Button"
            
            // Generate the keyboard node
            let bd_w = Float(self.frame.width)/2
            let bd_h = Float(self.frame.height/10)
    //        let bd_x = self.frame.origin.x
            let bd_x = self.frame.midX
    //        let bd_y = self.frame.minY - CGFloat(bd_h)
            let bd_y = self.frame.midY
            
            let bt_num = 5
            let keybd = MusicBoard(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture, width: bd_w, height: bd_h)
            
            keybd.addButtons(bt_num)
            keybd.position = CGPoint(x: bd_x,y: bd_y)
            keybd.zPosition = 1
            
            self.addChild(keybd)
            addKeyboard = false
        }
    }
    
    // Handle Button
    @objc func buttonTap() {
        print("Button pressed")
    }
  
    
    
    public func insertFromChild() {
        let playAndRemove = SKAction.sequence([.playSoundFileNamed("audio", waitForCompletion: true)])
        self.run(playAndRemove)
        
        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
        
        n.position = CGPoint(x: 200, y: 400)
        n.strokeColor = SKColor(red: CGFloat(Utils.random()), green: CGFloat(Utils.random()), blue: CGFloat(Utils.random()), alpha: 1)
        
        addChild(n)
        
        print("Inserted from child")
    }
    
    
    public func insertPulse() {
        let w = (size.width + size.height) * 0.05
        
        spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.5)
        spinnyNode.lineWidth = 2.5
        
        
        let fadeAndRemove = SKAction.sequence([
            .fadeOut(withDuration: 1),
            .removeFromParent()])
        
        
        let grow = SKAction.sequence([.scale(by: CGFloat(2), duration: 1)])
        
        
        spinnyNode.run(.repeatForever(.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        spinnyNode.run(grow)
        spinnyNode.run(fadeAndRemove)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        let playAndRemove = SKAction.sequence([.playSoundFileNamed("audio", waitForCompletion: true)])
        self.run(playAndRemove)
        
        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
        
        n.position = pos
        n.strokeColor = SKColor.green
        
        shouldPlay = true
        
        addChild(n)
        
    }
    
    
    func touchMoved(toPoint pos : CGPoint) {
        guard let n = self.spinnyNode.copy() as? SKShapeNode else { return }
        
        n.position = pos
        n.strokeColor = SKColor.blue
        n.strokeColor = SKColor(red: CGFloat(Utils.random()), green: CGFloat(Utils.random()), blue: CGFloat(Utils.random()), alpha: 1)
        
        addChild(n)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
        
        n.position = pos
        n.strokeColor = SKColor.red
        addChild(n)
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


