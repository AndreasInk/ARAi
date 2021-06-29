//
//  CustomARView.swift
//  ARAi
//
//  Created by Andreas on 6/29/21.
//

//import SwiftUI
//import RealityKit
//import ARKit
//import Vision
//import Combine
//import MetalKit
//import RealityUI
//var transformations = [SIMD3<Float>]()
//var camera = Entity()
//var isGame = false
//
//class CustomARView: ARView {
//    
//    var box =  Bird.Scene()
//    var model: AppModel
//     var lastObservationTimestamp = Date()
//     var handPoseRequest = VNDetectHumanHandPoseRequest()
//    enum FocusStyleChoices {
//      case classic
//      case material
//      case color
//    }
//   var i = 0
//   // var location: Location
//    // Referring to @EnvironmentObject
//    let focusStyle: FocusStyleChoices = .classic
////    var focusEntity: FocusEntity?
////    var saveLoadState: SaveLoadState
////    var arState: ARState
//    var distances = [SIMD3<Float>]()
//    var anchorz = [ARAnchor]()
//    let screenDemensions = UIScreen.main.bounds
//
//    let queue = DispatchQueue(label: "thread-safe-obj", attributes: .concurrent)
//   
//    var defaultConfiguration: ARWorldTrackingConfiguration {
//        let configuration = ARWorldTrackingConfiguration()
//        
//        configuration.planeDetection = [.horizontal]
//        configuration.environmentTexturing = .automatic
//        
//        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
//            configuration.sceneReconstruction = .meshWithClassification
//            configuration.frameSemantics = .sceneDepth
//            
//        }
//        return configuration
//    }
//    // MARK: - Init and setup
//  
//    required init(frame frameRect: CGRect, model: AppModel) {
////        self.saveLoadState = saveLoadState
////        self.arState = arState
////        self.location = location
//       
//        self.model = model
//        super.init(frame: frameRect)
//       
////        switch self.focusStyle {
////        case .color:
////          self.focusEntity = FocusEntity(on: self, focus: .plane)
////        case .material:
////          do {
////            let onColor: MaterialColorParameter = try .texture(.load(named: "Add"))
////            let offColor: MaterialColorParameter = try .texture(.load(named: "Open"))
////            self.focusEntity = FocusEntity(
////              on: self,
////              style: .colored(
////                onColor: onColor, offColor: offColor,
////                nonTrackingColor: offColor
////              )
////            )
////          } catch {
////            self.focusEntity = FocusEntity(on: self, focus: .classic)
////            print("Unable to load plane textures")
////            print(error.localizedDescription)
////          }
////        default:
////          self.focusEntity = FocusEntity(on: self, focus: .classic)
////
////        }
//    }
//    
//    @objc required dynamic init?(coder decoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc required dynamic init(frame frameRect: CGRect) {
//        fatalError("init(frame:) has not been implemented")
//    }
//    
//
////    @objc required dynamic init?(coder decoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//   
////    @objc required dynamic init(frame frameRect: CGRect) {
////        fatalError("init(frame:) has not been implemented")
////    }
//    var subscriptions = Set<AnyCancellable>()
//    func setup() {
////        model.scanning.sink {
////            if !ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
////                self.model.error.send()
////            }
////            self.debugOptions.insert(.showSceneUnderstanding)
////        }.store(in: &subscriptions)
////        var entity = RUIText(with: "The Boss Burger", width: 20, height: 1000, font:MeshResource.Font.init(name: "Avenir Next", size: 1.0)! , extrusion: 0.001, color: UIColor.white)
////
////
////                entity.scale = SIMD3<Float>(0.03, 0.03, 0.1)
////
////        var entity2 = RUIText(with: "The burger all other burgers report to. Smoked brisket, tender rib meat, jalapeno-cheddar smoked sausage, bacon & cheddar with lettuce, tomato, House BBQ & house-made ranch. We. Dare. You.", width: 10, height: 1000, font:MeshResource.Font.init(name: "Avenir Next", size: 1.0)! , extrusion: 0.001, color: UIColor.white)
////                entity2.scale = SIMD3<Float>(0.01, 0.01, 0.1)
//        
//        //entity.look(at: SIMD3<Float>(x: 1, y: 0.5, z: 1), from: entity.transform.translation, relativeTo: entity)
////        let radians = 90.0 * Float.pi / 180.0
////        entity.look(at: SIMD3<Float>(x: 0, y: 0, z: 1), from: entity2.transform.translation, relativeTo: entity2)
////        //entity.orientation = simd_quatf(angle: radians, axis: SIMD3(x: 1, y: 0, z: 0.5))
////        entity2.look(at: SIMD3<Float>(x: 0, y: 0, z: 1), from: entity2.transform.translation, relativeTo: entity2)
////        entity.setPosition(SIMD3<Float>(x: -0.2, y: 0.1, z: -0.2), relativeTo: self.box)
////        entity2.setPosition(SIMD3<Float>(x: -0.2, y: 0.2, z: -0.2), relativeTo: self.box)
//       
//       // DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//        do {
//            if isGame {
//              
//                box = try Bird.loadScene()
//                
//            } else {
//                box = try Bird.loadScene()
//            }
//           
//            
//          // Add the box anchor to the scene
//         
//          
//          // Use the flip trigger signal to send notification.
//            model.plusOne.sink {
//               
//            }.store(in: &subscriptions)
//            model.die.sink {
//               
//            }.store(in: &subscriptions)
//         
//            } catch {
//            }
//           // }
//       // }
//       
//        self.session.run(defaultConfiguration)
//        self.session.delegate = self
//        
//        
//       
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient,  options: .duckOthers)
//        } catch {
//            
//        }
//       // let box = CustomBox(color: UIColor.white)
//        
//        //self.scene.addAnchor(box)
//        //self.debugOptions = [ .showFeaturePoints ]
//        let timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            camera.position = self.cameraTransform.translation
//            
//           // box.position = (self.focusEntity?.position)!
//           // box.scale =  SIMD3(x: Float(scalesX.last ?? 1.0), y: Float(scalesY.last ?? 1.0), z: Float(scalesZ.last ?? 1.0))
//            
//          
//        }
//    
//    }
//    
//    // MARK: - AR content
//    var virtualObjectAnchor: ARAnchor?
//    let virtualObjectAnchorName = "virtualObject"
//    var virtualObject = Entity()
//    
//    
//    // MARK: - AR session management
//    var isRelocalizingMap = false
//    
// 
//    // MARK: - Persistence: Saving and Loading
//    let storedData = UserDefaults.standard
//    
//
//    lazy var worldMapData: Data? = {
//    storedData.data(forKey: "location.id.uuidString")
//    }()
//    
//    func resetTracking() {
//        self.session.run(defaultConfiguration, options: [.resetTracking, .removeExistingAnchors])
//        self.isRelocalizingMap = false
//        self.virtualObjectAnchor = nil
//    }
//    
//    
//    
//}
//var coolDown3 = false
//var directions = [String]()
//
//
//
//
//import SwiftUI
//import ARKit
//import RealityKit
//
//var placeIntitialAnchor = false
//var addAudio = false
//extension CustomARView {
//
//    /// Add the tap gesture recogniser
//    func setupGestures() {
//      let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//      self.addGestureRecognizer(tap)
//        
//       
//    }
//
//    // MARK: - Placing AR Content
//    
//    func rayCastingMethod(point: CGPoint) {
//        
//        
//        guard let raycastQuery = self.makeRaycastQuery(from: point,
//                                                       allowing: .existingPlaneInfinite,
//                                                       alignment: .horizontal) else {
//            
//            print("failed first")
//            placed = false
//            return
//        }
//        
//        guard let result = self.session.raycast(raycastQuery).first else {
//            print("failed")
//            placed = false
//            return
//        }
//      
//            let transformation = Transform(matrix: result.worldTransform)
//       // if virtualObjectAnchor != nil {
//            //let distance = AnchorEntity(raycastResult: result).position(relativeTo: AnchorEntity(world: virtualObjectAnchor!.transform))
//         //   distances.append(distance)
//            transformations.append(transformation.translation)
//           // print(distance)
//            placed = true
//     //   }
//        i += 1
//        
//    }
// 
//
//    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        self.box.notifications.flap.post()
//          
//       }
//    
//}
//var i = 0
//var placed = false
