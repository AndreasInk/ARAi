//
//  ARViewContainer.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

//import SwiftUI
//import RealityKit
//import ARKit
//import ZIPFoundation
//
//var model = Entity()
//struct ARViewContainer: UIViewRepresentable {
//    @Binding var item: Item
//    @Binding var category: Category
//    @ObservedObject var userData: UserData
//   
//    func makeUIView(context: Context) -> ARView {
//        
//        let arView = ARView(frame: .zero)
//       // let url = Bundle.main.url(forResource: "banana", withExtension: "usdz")!
//        let boxAnchor = try! Blank.loadScene()
//        //worldBlock = ((try? Entity.load(contentsOf: url)) ?? Entity())!
//        if category.name != "Your Models" {
//            if item.name == "Toliet Paper" {
//                let url = Bundle.main.url(forResource: "TP", withExtension: "reality")!
//               
//                 worldBlock = ((try? Entity.load(contentsOf: url)) ?? Entity())!
//            } else {
//            let url = Bundle.main.url(forResource: item.name, withExtension: "reality")!
//           
//             worldBlock = ((try? Entity.load(contentsOf: url)) ?? Entity())!
//        }
//        } else {
//            
//           
//      
//        }
//        let configuration = ARWorldTrackingConfiguration()
//        configuration.isAutoFocusEnabled = true
//       // configuration.trackingImages = referenceImages
//        //configuration.maximumNumberOfTrackedImages = .inf
//        configuration.planeDetection = [.horizontal]
//        //Enables People Occulusion on supported iOS Devices
////        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
////            configuration.frameSemantics.insert(.personSegmentationWithDepth)
////        } else {
////            print("People Segmentation not enabled.")
////        }
//
//        arView.session.run(configuration)
//        // Add the box anchor to the scene
//            
//        //arView.setupGestures()
//        arView.addCoaching()
//        boxAnchor.anchor?.addChild(worldBlock)
//            arView.scene.anchors.append(boxAnchor)
//        //arView.scene.anchors[0].addChild(worldBlock, preservingWorldTransform: true)
//                    
//               
//            
//
//       
//        
//        return arView
//        
//        
//    }
//   
//    
//    
//   
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
//extension ARView: ARCoachingOverlayViewDelegate {
//    func addCoaching() {
//        
//        let coachingOverlay = ARCoachingOverlayView()
//        coachingOverlay.delegate = self
//        coachingOverlay.session = self.session
//        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        coachingOverlay.goal = .horizontalPlane
//        self.addSubview(coachingOverlay)
//    }
//    
//    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
//        //Ready to add entities next?
//    }
//}
