//
//  ViewController.swift
//  DiceAR
//
//  Created by yuma@duck on 3/2/18.
//  Copyright © 2018 yuma@duck. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
// new comment
class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var trackerNode: SCNNode!
    var diceNode: SCNNode!
    var dice2Node: SCNNode!
    var trackingPosition = SCNVector3Make(0.0, 0.0, 0.0)
    var started = false
    var foundSurface = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene(named: "art.scnassets/Scene.scn")!
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func rollDice(dice: SCNNode) {
        if dice.physicsBody == nil {
            dice.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        }
        dice.physicsBody?.angularDamping = 0.5
        dice.physicsBody?.applyForce(SCNVector3Make(0.0, 3.0, 0.0), asImpulse: true)
        dice.physicsBody?.applyTorque(SCNVector4Make(1.0, 1.0, 1.0, 0.1), asImpulse: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if started {
            rollDice(dice: diceNode)
            rollDice(dice: dice2Node)
        } else {
            guard (trackerNode != nil) else { return }
            started = true
            //guard let dice = sceneView.scene.rootNode.childNode(withName: "dice", recursively: false) else { return }
            sceneView.scene.physicsWorld.gravity = SCNVector3(0.0, -10.0, 0.0)
            sceneView.scene.physicsWorld.speed = 0.8
            let floorPlane1 = SCNPlane(width: 0.3, height: 0.3)
            floorPlane1.firstMaterial?.diffuse.contents = UIColor.clear
            floorPlane1.firstMaterial?.isDoubleSided = true
            
            let floorNode1 = SCNNode(geometry: floorPlane1)
            floorNode1.position = trackingPosition
            floorNode1.position.z = floorNode1.position.z + 0.15
            //floorNode1.position.y = floorNode1.position.y + 0.15
            floorNode1.eulerAngles.x = 0
            floorNode1.opacity = 0.5
            sceneView.scene.rootNode.addChildNode(floorNode1)
            floorNode1.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            
            let floorPlane2 = SCNPlane(width: 0.3, height: 0.3)
            floorPlane2.firstMaterial?.diffuse.contents = UIColor.clear
            floorPlane2.firstMaterial?.isDoubleSided = true
            
            let floorNode2 = SCNNode(geometry: floorPlane2)
            floorNode2.position = trackingPosition
            floorNode2.position.z = floorNode2.position.z - 0.15
            floorNode2.eulerAngles.x = 0
            
            floorNode2.opacity = 0.5
            sceneView.scene.rootNode.addChildNode(floorNode2)
            floorNode2.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            
            let floorPlane3 = SCNPlane(width: 0.3, height: 0.3)
            floorPlane3.firstMaterial?.diffuse.contents = UIColor.clear
            
            let floorNode3 = SCNNode(geometry: floorPlane3)
            floorNode3.position = trackingPosition
            floorNode3.position.x = floorNode3.position.x + 0.15
            floorNode3.eulerAngles.y = 0.5 * .pi
            floorNode3.opacity = 0.5
            sceneView.scene.rootNode.addChildNode(floorNode3)
            floorNode3.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            
            let floorPlane4 = SCNPlane(width: 0.3, height: 0.3)
            floorPlane4.firstMaterial?.diffuse.contents = UIColor.clear
            
            let floorNode4 = SCNNode(geometry: floorPlane4)
            floorNode4.position = trackingPosition
            floorNode4.position.x = floorNode4.position.x - 0.15
            floorNode4.eulerAngles.y = 0.5 * .pi
            floorNode4.opacity = 0.5
            sceneView.scene.rootNode.addChildNode(floorNode4)
            floorNode4.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            
            let floorPlane5 = SCNPlane(width: 0.3, height: 0.3)
            floorPlane5.firstMaterial?.diffuse.contents = UIColor.clear
            floorPlane5.firstMaterial?.isDoubleSided = true
            let floorNode5 = SCNNode(geometry: floorPlane5)
            floorNode5.position = trackingPosition
            floorNode5.position.y = floorNode5.position.y + 0.15
            floorNode5.eulerAngles.z = .pi * 0.5
            floorNode5.eulerAngles.y = -.pi * 0.5
            floorNode5.opacity = 0.5
            sceneView.scene.rootNode.addChildNode(floorNode5)
            floorNode5.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            
            let floorPlane6 = SCNPlane(width: 0.3, height: 0.3)
            floorPlane6.firstMaterial?.diffuse.contents = UIColor.clear
            
            let floorNode6 = SCNNode(geometry: floorPlane6)
            floorNode6.position = trackingPosition
            floorNode6.position.y = floorNode6.position.y - 0.15
            floorNode6.eulerAngles.z = .pi * 0.5
            floorNode6.eulerAngles.y = -.pi * 0.5
            floorNode6.opacity = 0.5
            sceneView.scene.rootNode.addChildNode(floorNode6)
            floorNode6.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            
            guard let dice = sceneView.scene.rootNode.childNode(withName: "dice", recursively: false) else { return }
            diceNode = dice
            diceNode.position = SCNVector3Make(trackingPosition.x, trackingPosition.y + 0.05, trackingPosition.z)
            diceNode.isHidden = false
            
            dice2Node = diceNode.clone()
            dice2Node.position.x = trackingPosition.x + 0.04
            sceneView.scene.rootNode.addChildNode(dice2Node)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard !started else { return }
        guard let hitTest = sceneView.hitTest(CGPoint(x: view.frame.midX, y: view.frame.midY), types: [.existingPlane, .featurePoint, .estimatedHorizontalPlane]).first else { return }
        let trans = SCNMatrix4(hitTest.worldTransform)
        trackingPosition = SCNVector3Make(trans.m41, trans.m42, trans.m43)
        
        if !foundSurface {
            let trackerPlane = SCNPlane(width: 0.2, height: 0.2)
            trackerPlane.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "tracker")
            trackerPlane.firstMaterial?.isDoubleSided = true
            
            trackerNode = SCNNode(geometry: trackerPlane)
            trackerNode.eulerAngles.x = -.pi * 0.5
            sceneView.scene.rootNode.addChildNode(trackerNode)
            
            foundSurface = true
        }
        
        trackerNode.position = trackingPosition
    }
}
