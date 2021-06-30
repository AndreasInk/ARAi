//
//  BirdView.swift
//  ARAi
//
//  Created by Andreas on 6/29/21.
//
//
import Foundation
import RealityKit
import ARKit
import AVFoundation
import Combine
import MetalKit
class AppModel: ObservableObject {
    let die = PassthroughSubject<Void, Never>()
    let plusOne = PassthroughSubject<Void, Never>()
//    let game = PassthroughSubject<Void, Never>()
//    let saveScan = PassthroughSubject<Void, Never>()
//    let scanning = PassthroughSubject<Void, Never>()
//    let error = PassthroughSubject<Void, Never>()
}
//public var entities = [Entity]()
//
//extension CustomARView {
//    
//   
//    
//    func addAnchorEntityToScene(anchor: ARAnchor) {
//        do {
//       
//        guard anchor.name == virtualObjectAnchorName else {
//            return
//        }
//        // save the reference to the virtual object anchor when the anchor is added from relocalizing
//        if virtualObjectAnchor == nil {
//            virtualObjectAnchor = anchor
//        }
//        do {
//           
//            let modelEntity = box//virtualObject
//            print("DEBUG: adding model to scene - \(virtualObject.name)")
//            
//        let physicsResource: PhysicsMaterialResource = .generate(friction: 10,
//                                                              restitution: 0)
//            
//            modelEntity.components[PhysicsBodyComponent] = PhysicsBodyComponent(
//                                                shapes: [.generateBox(size: SIMD3(x: 1, y: 1, z: 1))],
//                                                  mass: 20,         // in kilograms
//                                              material: physicsResource,
//                mode: .static)
//            modelEntity.generateCollisionShapes(recursive: true)
//            // Add modelEntity and anchorEntity into the scene for rendering
//            let anchorEntity = AnchorEntity(anchor: anchor)
//            
//            anchorEntity.addChild(modelEntity)
////            let  reviews = StickyNoteEntity(frame: CGRect(x: 200, y: 200, width: 500, height: 500), worldTransform: anchor.transform)
////            //reviews.setPosition(SIMD3<Float>(0, 0.1, 0), relativeTo: self.box.burger)
////            self.scene.anchors.append(reviews)
////            guard let projectedPoint = self.project(reviews.position) else { return }
////
////            // Calculates whether the note can be currently visible by the camera.
////            let cameraForward = self.cameraTransform.matrix.columns.2.xyz
////            let cameraToWorldPointDirection = normalize(reviews.transform.translation - self.cameraTransform.translation)
////            reviews.setPositionCenter(projectedPoint)
////            let dotProduct = dot(cameraForward, cameraToWorldPointDirection)
////            let isVisible = dotProduct < 0
////
////            // Updates the screen position of the note based on its visibility
////            reviews.projection = Projection(projectedPoint: projectedPoint, isVisible: true)
////            reviews.updateScreenPosition()
//           
//            
//            modelEntity.transform = Transform(matrix: anchor.transform)
//            do {
//               
//                   try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient,  options: .duckOthers)
//                
//            } catch {
//                
//            }
//            anchorz.append(virtualObjectAnchor!)
//            directions = directions.removeDuplicates()
//            transformations = transformations.removeDuplicates()
//            for i2 in transformations.indices {
//                
//                var stop = false
//               // var box = try (directions[i2] ?? "") == "Home" ? Burger.loadScene().burger! : Burger.loadScene().hotdog!
//                var played = false
//                box.transform.translation = SIMD3(x: transformations[i2].x
//, y: transformations[i2].y + 2, z: transformations[i2].z) //transformations[i2]
//              //  box.scale =  SIMD3(x: Float(scalesX.last ?? 1.0), y: Float(scalesY.last ?? 1.0), z: Float(scalesZ.last ?? 1.0))
//                //if (directions[i2]) == "Pickup" {
//                    
////                var material = SimpleMaterial()
////                            material.baseColor = try! .texture(.load(named: "list.jpeg"))
////
////                var component: ModelComponent = ModelComponent(mesh: MeshResource.generateBox(size: SIMD3(x: 31.31, y: 63.75, z: 3.55)), materials: [material])
////                            component.materials = [material]
////                box.components.set(component)
//               
//                
//           // }
//                //box.position = (distances[i])
//               // anchorEntity.addChild(box)
//              //  ARMenu.entities.append(box)
////                let audioSource = SCNAudioSource(fileNamed: "002.mp3")!
////                audioSource.loops = false
////
////                // Decode the audio from disk ahead of time to prevent a delay in playback
////                audioSource.load()
////                do {
////                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient,  options: .duckOthers)
////                } catch {
////
////                }
//                
////                let audioFilePath = "002.mp3"
////
////
////                do {
////                    let resource = try AudioFileResource.load(named: audioFilePath, in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: true)
////                    let audioController = box.prepareAudio(resource)
////                    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
////
////                        if Access.entities.count > step {
////                                    if Access.entities[step] == box {
////                                print(i2)
////                                       // audioController.play()
////                                                        timer.invalidate()
////
////                            } else {
////                                //audioController.pause()
////                            }
////                        }
////                    }
////                let timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
////
////                    let anchorPosition = box.transform.translation
////                    let cameraPosition = camera.transform.translation
////
////                    // here’s a line connecting the two points, which might be useful for other things
////
////                    let distance = length(camera.position(relativeTo: box))
////                  //  print(distance)
////                    if distance < 1.1  {
////                        if self.location.directions.count > step  {
////                      //  self.playSound(audioName: directions[step])
////                        }
////                        stop = true
////                        audioController.stop()
////                        if !coolDown {
////
////                          coolDown = true
////                            step += 1
////                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
////                            coolDown = false
////                        }
////                        }
////
////
////
////                    }
////                }
////
////                } catch {
////
////                }
//            }
//            self.scene.anchors.append(anchorEntity)
//        }  catch {
//            
//        }
//        } catch {
//        }
//        }
//    func playSound(audioName: String) {
//         guard let url = Bundle.main.url(forResource: audioName, withExtension: "mp3") else { return }
//        if !coolDown {
//           
//         do {
//            
//                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient,  options: .mixWithOthers)
//               
//            
//          
//             try AVAudioSession.sharedInstance().setActive(true)
//         
//         
//             /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
//             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//             /* iOS 10 and earlier require the following line:
//             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
//
//             guard let player = player else { return }
//
//             player.play()
//
//           
//            
//         } catch let error {
//             print(error.localizedDescription)
//         }
//           
//            coolDown = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                coolDown = false
//            }
//            }
//        
// }
//   
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        
//       
//                
//        // Fetch all ARMeshAncors
//       
////        var thumbTip: CGPoint?
////        var indexTip: CGPoint?
//////        defer {
//////            DispatchQueue.main.sync {
//////                //self.processPoints(thumbTip: thumbTip, indexTip: indexTip)
//////            }
//////        }
////
////        let handler = VNImageRequestHandler(cvPixelBuffer: frame.capturedImage, orientation: .up, options: [:])
////        do {
////            // Perform VNDetectHumanHandPoseRequest
////            try handler.perform([handPoseRequest])
////            // Continue only when a hand was detected in the frame.
////            // Since we set the maximumHandCount property of the request to 1, there will be at most one observation.
////            guard let observation = handPoseRequest.results?.first else {
////                return
////            }
////            // Get points for thumb and index finger.
////            let thumbPoints = try observation.recognizedPoints(.thumb)
////            let indexFingerPoints = try observation.recognizedPoints(.indexFinger)
////            // Look for tip points.
////            guard let thumbTipPoint = thumbPoints[.thumbTip], let indexTipPoint = indexFingerPoints[.indexTip] else {
////                return
////            }
////            // Ignore low confidence points.
////            guard  indexTipPoint.confidence > 0.3 else {
////                return
////            }
////            // Convert points from Vision coordinates to AVFoundation coordinates.
////            thumbTip = CGPoint(x: thumbTipPoint.location.x, y: 1 - thumbTipPoint.location.y)
////            indexTip = CGPoint(x: indexTipPoint.location.x, y: 1 - indexTipPoint.location.y)
////
////           // print(indexTip?.y)
////        } catch {
//////            cameraFeedSession?.stopRunning()
//////            let error = AppError.visionError(error: error)
////            DispatchQueue.main.async {
//////                error.displayInViewController(self)
////            }
////        }
//   }
//}
//    var step = 0
//var coolDown = false
//var player: AVAudioPlayer?
//extension CustomARView: ARSessionDelegate {
//    
//    // MARK: - AR session delegate
//  
//    // This is where we render virtual contents to scene.
//    // We add an anchor in `handleTap` function, it will then call this function.
//    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
//        print("did add anchor: \(anchors.count) anchors in total")
//       
//        for anchor in anchors {
//            addAnchorEntityToScene(anchor: anchor)
//        }
//    
//    }
//    
//   
//
//    // write
//    
//    
//}
//var coolDown2 = false
//
//
