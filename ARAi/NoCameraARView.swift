//
//  NoCameraARView.swift
//  Model
//
//  Created by Andreas on 6/8/21.
//
//
import SwiftUI
import ARKit
import RealityKit
import Combine

struct NoCameraARViewContainer: UIViewRepresentable {
    @Binding var entity: Entity
    var sceneEventsUpdateSubscription: Cancellable!
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .nonAR,
                            automaticallyConfigureSession: false)
        arView.backgroundColor = .clear
        do {
       let boxAnchor = AnchorEntity(world: .zero)
       
        // Load the "Box" scene from the "Experience" Reality File
        do {
        let url = Bundle.main.url(forResource: "Banana", withExtension: "reality")!
        
        //let food = ((try? Entity.load(contentsOf: url)) ?? boxAnchor.parent)!
        entity = try Entity.load(contentsOf: url)
            boxAnchor.anchor?.addChild(entity)
        // Add the box anchor to the scene
            arView.scene.addAnchor(boxAnchor)
            
            var sphereMaterial = SimpleMaterial()
                  sphereMaterial.metallic = MaterialScalarParameter(floatLiteral: 1)
                  sphereMaterial.roughness = MaterialScalarParameter(floatLiteral: 0)
            let sphereEntity = ModelEntity(mesh: .generateSphere(radius: 1), materials: [sphereMaterial])
                   let sphereAnchor = AnchorEntity(world: .zero)
                   sphereAnchor.addChild(sphereEntity)
                   arView.scene.anchors.append(sphereAnchor)
            let camera = PerspectiveCamera()
                   camera.camera.fieldOfViewInDegrees = 60
                   
                   let cameraAnchor = AnchorEntity(world: .zero)
                   cameraAnchor.addChild(camera)
                   
                   arView.scene.addAnchor(cameraAnchor)

                   let cameraDistance: Float = 3
                   var currentCameraRotation: Float = 0
                   let cameraRotationSpeed: Float = 0.01

//                   sceneEventsUpdateSubscription = arView.scene.subscribe(to: SceneEvents.Update.self) { _ in
//                       let x = sin(currentCameraRotation) * cameraDistance
//                       let z = cos(currentCameraRotation) * cameraDistance
//                       
//                       let cameraTranslation = SIMD3<Float>(x, 0, z)
//                       let cameraTransform = Transform(scale: .one,
//                                                       rotation: simd_quatf(),
//                                                       translation: cameraTranslation)
//                       
//                       camera.transform = cameraTransform
//                       camera.look(at: .zero, from: cameraTranslation, relativeTo: nil)
//
//                       currentCameraRotation += cameraRotationSpeed
//                   }
        } catch {
            print(1)
        }
        } catch {
            print(0)
        }
        return arView
        
        
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
