//
//  ARGestures.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//

//import SwiftUI
//import ARKit
//import RealityKit
//
//var i = 0
//var tapped = false
//extension ARView {
//    
//    func setupGestures() {
//        
////        do {
////        worldBlock = try  NotAWalkInThePark.loadScene().clone(recursive: true)
////        //box = try  Vision.loadScene().clone(recursive: true)
////        } catch {
////
////        }
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        self.addGestureRecognizer(tap)
//        
//        
//        
//    }
//    
//    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        
//        guard let touchInView = sender?.location(in: self) else {
//            return
//        }
//       
//        rayCastingMethod(point: touchInView)
//        withAnimation(.easeInOut) {
//        tapped = true
//        }
//        //to find whether an entity exists at the point of contact
//        
//        
//        
//    }
//    
//    
//    func rayCastingMethod(point: CGPoint) {
//        
//       
//        
//        guard let raycastQuery = self.makeRaycastQuery(from: point,
//                                                       allowing: .estimatedPlane,
//                                                       alignment: .horizontal) else {
//            
//            print("failed first")
//            return
//        }
//        
//        guard let result = self.session.raycast(raycastQuery).first else {
//            print("failed")
//            return
//        }
//        
//        let transformation = Transform(matrix: result.worldTransform)
//        virtualObjectAnchor = ARAnchor(
//                           name: "",
//                               transform: result.worldTransform
//                           )
//       
//        //guard let coordinator = self.session.delegate as? ARViewCoordinator else{ print("GOOD NIGHT"); return }
//      
//            print("first")
//            raycastAnchor = AnchorEntity(raycastResult: result)
//        spawnWorldBlock(transformation: transformation)
//            
//            placeIntitialAnchor = false
//                            placed = true
//           
//        
//        
//    }
//        
//        //bowlingScene.playAnimation(bowlingScene.availableAnimations.first!)
//    
//    func spawnWorldBlock(transformation: Transform) {
//       
//       
//           
//        
//        do {
//            
//        worldBlock.transform = transformation
//           
//        raycastAnchor.addChild(worldBlock)
//        self.scene.addAnchor(raycastAnchor)
//            for transformation in transformations {
//                spawnChildBlock(position: transformation)
//            }
//            transformations.append(transformation.translation)
//            
//        } catch {
//    }
//        
//    }
//    
//    func spawnChildBlock(position: SIMD3<Float>) {
//        do {
//       
//            let box2 = box.clone(recursive: true)
//            box2.setPosition(position, relativeTo: raycastAnchor)
//        raycastAnchor.addChild(box2)
//            transformations.append(position)
//            
//        } catch {
//    }
//    }
//}
//
//
//
//var worldBlock = Entity()
//var box = Entity()
//
//var raycastAnchor = AnchorEntity()
//
//var placeIntitialAnchor = false
//
//
//var transformations = [SIMD3<Float>]()
//
//var reset = false
//
//var load = false
//
//var virtualObjectAnchor: ARAnchor?
//
//var placed = false
//
