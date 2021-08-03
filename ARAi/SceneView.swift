//
//  SceneView.swift
//  ARAi
//
//  Created by Andreas on 7/1/21.
//

import SwiftUI
import SceneKit
import SceneKit.ModelIO
struct SceneView: UIViewRepresentable {
    @Binding  var points: [POINT3D]
    @Binding  var gestureOn: Bool
    var scene: SCNScene
    var options: [Any]
    @ObservedObject var thing: Thing
    
    var view = SCNView()
    
    func makeUIView(context: Context) -> SCNView {
        
        // Instantiate the SCNView and setup the scene
        view.scene = scene
        view.pointOfView = scene.rootNode.childNode(withName: "camera", recursively: true)
        view.allowsCameraControl = true
        do {
        let model = nodeFromResource(assetName: "pizza2", extensionName: "usdz")
        let modelScene =  try SCNScene(url: Bundle.main.url(forResource: "pizza2", withExtension: "usdz")!, options: nil)
           // print(modelScene.rootNode.childNodes.last?.childNodes.last?.geometry)
        model.position = SCNVector3Make(1, 1, 1)
            model.geometry?.firstMaterial?.lightingModel = .physicallyBased
               scene.rootNode.addChildNode(model)
            if let filePath = Bundle.main.path(forResource: "pizza2",
                                               ofType: "usdz") {

                let refURL = URL(fileURLWithPath: filePath)
                let mdlAsset = MDLAsset(url: refURL)
               
               // scene.rootNode.childNodes.app = SCNScene(mdlAsset: mdlAsset)

                let tvNode = scene.rootNode.childNode(withName: "g0", recursively: true)
                let geometry = tvNode!.geometry!
                
                for i in geometry.elements.indices {
//                                let element = geometry.element(at: i)
                    let vertices = vertices(node: tvNode!)
                    for vert in vertices {
                   
                        let box = SCNBox(width: 0.002, height: 0.002, length: 0.002, chamferRadius: 0)
                            box.firstMaterial?.diffuse.contents = UIColor.black
                            box.firstMaterial?.isDoubleSided = true
                            let boxNode = SCNNode(geometry: box)
                        boxNode.position = SCNVector3(Float.random(in: -1000...1000), Float.random(in: -1000...1000), Float.random(in: -1000...1000))
                        model.addChildNode(boxNode)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        SCNAction.move(to: SCNVector3(vert.x, vert.y, vert.z), duration: TimeInterval.random(in: 5...60))
                        }
                        //print(boxNode.position)
                             
                       
                        
                        points.append(POINT3D(x: boxNode.position.x, y: boxNode.position.y, z: boxNode.position.z))
                    }
                   
                }
               
                tvNode!.opacity = 1.0
            } else {

                print("invalid path!")

            }
           
        //points = loadPointCloud(modelFile:Bundle.main.url(forResource: "pizza2", withExtension: "usdz")!)!
        
//                    for point in points {
//
//
//                    }
            
        } catch {
            
            
        }
        // Add gesture recognizer
       
        let tapGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
       
            if thing.export {
                let tvNode = scene.rootNode.childNode(withName: "g0", recursively: true)
               
//                for i in thing.nodes.indices {
//                    if tvNode!.geometry!.elements.contains((thing.nodes[i].geometry?.elements.last)!) {
//                        tvNode!.geometry!.removeMaterial(at: i)
//
//
//                }
//            }
                
               
                let exportUrl =  getDocumentsDirectory().appendingPathComponent("test.usdz")
                if exportUrl.startAccessingSecurityScopedResource() {
                 
                let usdz = MDLAsset.canExportFileExtension("usdz")
                if usdz {
                do {
                    let modelScene =  try SCNScene(url: Bundle.main.url(forResource: "pizza2", withExtension: "usdz")!, options: nil)
                    let mdlScene = MDLAsset(scnScene: modelScene)
                    print(mdlScene)
                    let path = FileManager.default.urls(for: .cachesDirectory,
                                                         in: .userDomainMask)[0]
                                                             .appendingPathComponent("test.usdz")
                     modelScene.write(to: getDocumentsDirectory().appendingPathComponent("test.usdz"),
                                   options: nil,
                                  delegate: nil,
                           progressHandler: nil)
                    do { exportUrl.stopAccessingSecurityScopedResource() }
                } catch {
                    print(error)
                }
                } else {
                    print("No USDZ")
                }
                }
            }
        if !thing.gestureOn {
            view.removeGestureRecognizer(tapGesture)
        } else {
            
            view.addGestureRecognizer(tapGesture)
        }
        
        return view
    }
    func getDocumentsDirectory() -> URL {
            // find all possible documents directories for this user
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
            // just send back the first one, which ought to be the only one
            return paths[0]
        }
    func updateUIView(_ view: SCNView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(view)
    }
    
    class Coordinator: NSObject {
        private let view: SCNView
        init(_ view: SCNView) {
            self.view = view
            
            super.init()
        }
        
        @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
            // check what nodes are tapped
            let p = gestureRecognize.location(in: view)
            let hitResults = view.hitTest(p, options: [:])
            
            // check that we clicked on at least one object
            if hitResults.count > 0 {
                
                // retrieved the first clicked object
               
                for result in hitResults.filter( { $0.node.name != "g0" }) {
                    result.node.removeFromParentNode()
                // get material for selected geometry element
                let material = result.node.geometry!.materials[(result.geometryIndex)]
                
                // highlight it
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                // on completion - unhighlight
                SCNTransaction.completionBlock = {
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 0.5
                    
                   // material.emission.contents = UIColor.black
                  
                    SCNTransaction.commit()
                }
                material.emission.contents = UIColor.green
                SCNTransaction.commit()
                  
            }
        }
    }
    }
    func vertices(node:SCNNode) -> [SCNVector3] {
        let vertexSources = node.geometry?.sources(for: SCNGeometrySource.Semantic.vertex)
        if let vertexSource = vertexSources?.first {
            let count = vertexSource.data.count / MemoryLayout<SCNVector3>.size
            return vertexSource.data.withUnsafeBytes {
                [SCNVector3](UnsafeBufferPointer<SCNVector3>(start: $0, count: count))
            }
        }
        return []
    }
}
class Thing: ObservableObject {
    @Published var gestureOn: Bool = false
    @Published var scene: SCNScene = SCNScene()
    @Published var export: Bool = false
    @Published var nodes: [SCNNode] = [SCNNode]()
}
