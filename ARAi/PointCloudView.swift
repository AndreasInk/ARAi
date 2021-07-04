//
//  PointCloudView.swift
//  ARAi
//
//  Created by Andreas on 7/1/21.
//

import SwiftUI
import SceneKit
struct PointCloudView: View {
    @State var scene = SCNScene()
    @GestureState var touching = false
   
    @State private var soundFrames = [CGRect]()
       @State private var points = [POINT3D]()
    @StateObject var thing = Thing()
    @State var export = false
    @State var gestureOn = false
    var body: some View {
        VStack {
            SceneView(
                points: $points, gestureOn: $gestureOn, scene: scene, options: [], thing: thing)
                .onAppear() {
               
                }
//                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                                       .onChanged({ (value) in
//
//
//                                           //                                If there's a match activate the view by toggling state
//                   
//                    if let match = points.map{$0.x}.firstIndex(where: { CGFloat($0) == (CGFloat( value.location.x)  ) }) {
//                        if let match = points.map{$0.y}.firstIndex(where: { CGFloat($0) == (CGFloat( value.location.y)  ) }) {
//                            points.remove(at: match)
//                        }
//                                           } else {
//
//                                           }
//                                       })
//                                       .onEnded({ (_) in
//
//                                       })
//                           )
              

            Spacer()
                HStack(alignment: .top, spacing: 0, content: {
                    Button("Move") {
                        thing.gestureOn.toggle()
                        
                    }
                    .padding()
                    Button("Export") {
                        thing.gestureOn.toggle()
                        export = true
                    }
                    .padding()
                    Spacer()
                })
                .sheet(isPresented: $export) {
                    ShareSheet(
                        activityItems: [ getDocumentsDirectory().appendingPathComponent("test.usdz")  ],
                      excludedActivityTypes: [.copyToPasteboard])
                }
            

        }
    }
    func getDocumentsDirectory() -> URL {
            // find all possible documents directories for this user
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
            // just send back the first one, which ought to be the only one
            return paths[0]
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

struct PointCloudView_Previews: PreviewProvider {
    static var previews: some View {
        PointCloudView()
    }
}
func nodeFromResource(assetName: String, extensionName: String) -> SCNNode {
    let url = Bundle.main.url(forResource: "\(assetName)", withExtension: extensionName)!
    let node = SCNReferenceNode(url: url)!
    
    node.name = assetName
    node.load()
    return node
}
extension SCNGeometryElement {

/// Gets the `Element` vertices
func getVertices() -> [SCNVector3] {
    
    func vectorFromData<UInt: BinaryInteger>(_ float: UInt.Type, index: Int) -> SCNVector3 {
        assert(bytesPerIndex == MemoryLayout<UInt>.size)
        let vectorData = UnsafeMutablePointer<UInt>.allocate(capacity: bytesPerIndex)
        let buffer = UnsafeMutableBufferPointer(start: vectorData, count: primitiveCount)
        let stride = 3 * index
        self.data.copyBytes(to: buffer, from: stride * bytesPerIndex..<(stride * bytesPerIndex) + 3)
        return SCNVector3(
            CGFloat.NativeType(vectorData[0]),
            CGFloat.NativeType(vectorData[1]),
            CGFloat.NativeType(vectorData[2])
        )
    }
    
    let vectors = [SCNVector3](repeating: SCNVector3Zero, count: self.primitiveCount)
    return vectors.indices.map { index -> SCNVector3 in
        switch bytesPerIndex {
            case 2:
                return vectorFromData(Int16.self, index: index)
            case 4:
                return vectorFromData(Int.self, index: index)
            case 8:
                return SCNVector3Zero
            default:
                return SCNVector3Zero
        }
    }
}
}

