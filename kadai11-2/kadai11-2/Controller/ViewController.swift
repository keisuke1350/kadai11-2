//
//  ViewController.swift
//  kadai11-2
//
//  Created by 葛西　佳祐 on 2020/07/19.
//  Copyright © 2020 葛西　佳祐. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    let defaultConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        
        let images = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        configuration.detectionImages = images
            configuration.maximumNumberOfTrackedImages = 1
            return configuration
        }()
    
    let imageConfiguration: ARImageTrackingConfiguration = {
        let configuration = ARImageTrackingConfiguration()
        
        let images = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        configuration.trackingImages = images!
        configuration.maximumNumberOfTrackedImages = 1
        return configuration
    }()
    
    private var buttonNode: SCNNode!
    private var card2Node: SCNNode!
    private var errorNode: SCNNode!
    
    private let feedback = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    
        // デフォルトのライト
        sceneView.autoenablesDefaultLighting = true
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // ピカチューが表示されるNodeを作成
    func createPikaNode() -> SCNNode {
        let pikaScene = SCNScene(named: "art.scnassets/Pikachu/PikachuF_ColladaMax.scn")!

        let pikaNode = SCNNode()

        // PikachuF_ColladaMax.scnファイルの中のchildNodesにピカチューがいるので、取り出して、pikaNodeに追加
        for childNode in pikaScene.rootNode.childNodes {
            pikaNode.addChildNode(childNode)
        }

        // ピカチューの高さを調整する
        // pikaNodeの境界線の最小値と最大値を取得
        let (min, max) = (pikaNode.boundingBox)
        // Y軸方向の最大値と最小値の差がデフォルトの高さ
        let h = max.y - min.y
        // 0.4メートルを100%としたときの倍率を計算(例：hが1mだったとき、0.4)
        let magnification = 0.4 / h
        // x, y, z軸それぞれ上で計算した倍率をかけ算。高さは0.4ｍとなり、x, z軸方向も縦横高さ比を保ったまま拡大or縮小する。
        pikaNode.scale = SCNVector3(magnification, magnification, magnification)

        return pikaNode
    }

    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return nil
        }
        
        switch imageAnchor.referenceImage.name {
        case "ariimage":
            DispatchQueue.main.async {
                self.feedback.impactOccurred()
            }
            let pikaNode = createPikaNode()
            return pikaNode
        case "arnikuko":
            DispatchQueue.main.async {
                self.feedback.impactOccurred()
            }
            let pikaNode = createPikaNode()
            return pikaNode
        default:
            return nil
        }
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
