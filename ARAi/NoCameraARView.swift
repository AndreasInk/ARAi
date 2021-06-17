//
//  NoCameraARView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//
//
//import SwiftUI
//import ARKit
//import RealityKit
//struct NoCameraARViewContainer: UIViewRepresentable {
//    @Binding var entity: Entity
//    func makeUIView(context: Context) -> ARView {
//        
//        let arView = ARView(frame: .zero, cameraMode: .nonAR,
//                            automaticallyConfigureSession: false)
//        arView.backgroundColor = .clear
//        // Load the "Box" scene from the "Experience" Reality File
//        do {
//        let url = Bundle.main.url(forResource: "banana", withExtension: "usdz")!
//        
//        //let food = ((try? Entity.load(contentsOf: url)) ?? boxAnchor.parent)!
//        entity = try Entity.load(contentsOf: url, withName: "banana")
//            boxAnchor.anchor?.addChild(entity)
//        // Add the box anchor to the scene
//            arView.scene.anchors.append(boxAnchor)
//        } catch {
//            
//        }
//        return arView
//        
//        
//    }
//    func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        
//        // just send back the first one, which ought to be the only one
//        return paths[0]
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//    
//}
