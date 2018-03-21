import Foundation
import SpriteKit


public class GameScene: SKScene {
    
    
    private var label : SKLabelNode!
    public var spinnyNode : SKShapeNode!
    private var shouldPlay:Bool = false
    let button = SKSpriteNode(imageNamed: "white")
    var addKeyboard:Bool = true
    var board_w:CGFloat = 0
    var board_h:CGFloat = 0
    var board_x:CGFloat = 0
    var board_y:CGFloat = 0
  
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
            let buttonTextureSelected: SKTexture! = SKTexture(imageNamed: "Solid_gray")
            let button = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture, width: bt_w, height: bt_h)
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(buttonTap))
            button.position = CGPoint(x: self.frame.midX,y: self.frame.midY)
            button.zPosition = 1
            button.size = CGSize(width: 50, height: 50)
            
            button.name = "Button"
            
            // Generate the keyboard node
            let bd_w = Float(self.frame.width)/2
            let bd_h = Float(self.frame.height/6)
            let bd_x = self.frame.midX
            let bd_y = self.frame.midY - self.frame.height/2 + CGFloat(bd_h)/2 + 5
          
            // Record the keyboard size for the future
            self.board_h = CGFloat(bd_h)
            self.board_w = CGFloat(bd_w)
            self.board_x = bd_x
            self.board_y = bd_y
          
            let bt_num = 8
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
      
        let bx = self.board_x - self.board_w/2
        let ex = self.board_x + self.board_w/2 - 100
      // TODO: Verify how to 
        let ey = self.frame.midY + self.frame.height/2 - 50
        let by = self.board_y + self.board_h + 50
        let px = Utils.random(bx, ex)
        let py = Utils.random(by, ey)
        n.position = CGPoint(x: px, y: py)
        n.strokeColor = SKColor(red: CGFloat(Utils.random(CGFloat(0.2), CGFloat(1))), green: CGFloat(Utils.random(CGFloat(0.2), CGFloat(1))), blue: CGFloat(Utils.random(CGFloat(0.2), CGFloat(1))), alpha: 1)
        
        addChild(n)
        
//        print("Inserted from child")
    }
    
    
    public func insertPulse() {
        let w = (size.width + size.height) * 0.05
        
        spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.5)
        spinnyNode.lineWidth = 2.5
      
        let fadeAndRemove = SKAction.sequence([
            .fadeOut(withDuration: 1),
            .removeFromParent()])
      
        let grow = SKAction.sequence([.scale(by: CGFloat(3), duration: 1)])
      
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
//        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


