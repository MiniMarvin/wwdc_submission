import Foundation
import SpriteKit


public class PresentationScreen: SKScene {
  
  
  private var label : SKLabelNode!
  public var spinnyNode : SKShapeNode!
  private var shouldPlay:Bool = false
  let button = SKSpriteNode(imageNamed: "white")
  var addKeyboard:Bool = true
  var board_w:CGFloat = 0
  var board_h:CGFloat = 0
  var board_x:CGFloat = 0
  var board_y:CGFloat = 0
  
  
  public override func sceneDidLoad() {
    //    insertFromChild()
    //    addLogo()
    let node = SKLabelNode(fontNamed:"Chalkduster")
    node.text = "You win"
    //    node.isHidden = true
    node.fontSize = 60
    node.fontColor = SKColor.green
    node.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    self.addChild(node)
    
//    let appear = SKAction.sequence([
////      .hide(),
//      .wait(forDuration: 1),
//      .fadeIn(withDuration: 1),
//      .removeFromParent()])

//    node.run(appear)
    
    print("Scene loaded")
  }
  
  
  
  // MARK: Objects
  override public func didMove(to view: SKView) {
    //    insertPulse()
    //    insertLogo()
  }
  
  
  
  public func insertPulse() {
    let w = (size.width + size.height) * 0.05
    
    spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.5)
    spinnyNode.lineWidth = 2.5
    
    let fadeAndRemove = SKAction.sequence([
      .fadeOut(withDuration: 2),
      .removeFromParent()])
    
    let grow = SKAction.sequence([.scale(by: CGFloat(3), duration: 1)])
    
    spinnyNode.run(.repeatForever(.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
    spinnyNode.run(grow)
    spinnyNode.run(fadeAndRemove)
  }
  
  
  
  public func insertFromChild() {
    let playAndRemove = SKAction.sequence([.playSoundFileNamed("1", waitForCompletion: true)])
    self.run(playAndRemove)
    
    guard let n = spinnyNode.copy() as? SKShapeNode else { return }
    
    let px = self.frame.midX
    let py = self.frame.midY
    n.position = CGPoint(x: px, y: py)
    n.strokeColor = SKColor(red: CGFloat(Utils.random(CGFloat(0.2), CGFloat(1))), green: CGFloat(Utils.random(CGFloat(0.2), CGFloat(1))), blue: CGFloat(Utils.random(CGFloat(0.2), CGFloat(1))), alpha: 1)
    
    addChild(n)
  }
  
  public func insertLogo() {
    label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = "Songo"
    label.isHidden = true
    label.fontSize = 60
    label.fontColor = SKColor.green
    label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    
    let appear = SKAction.sequence([
      .wait(forDuration: 1),
      .fadeIn(withDuration: 1),
      .removeFromParent()])
    
    label.run(appear)
  }
  
  public func addLogo() {
    guard let n = label.copy() as? SKLabelNode else { return }
    
    let px = self.frame.midX
    let py = self.frame.midY
    //    n.position = CGPoint(x: px, y: py)
    
    addChild(n)
  }
}

