//
//  PointCloud.swift
//  ARAi
//
//  Created by Andreas on 7/1/21.
//

import Foundation
import ModelIO

private func LogDebug(_ s:Any) -> Void { print(s) }
private func LogInfo(_ s:Any) -> Void { print(s) }
private func LogError(_ s:Any) -> Void { print(s) }

struct POINT3D {
  var x:Float
  var y:Float
  var z:Float
}

/**
 Reads a 3D model and returns an array of its vertex position coordinates
 If the model loads into Model I/O with a transform associated with the mesh,
 this function will return not the vertex positions as loaded, but as loaded
 and transformed.
 Does not preserve the vertex order used in the file.
 Returns nil if the model does not load into the required format
 - precondition: Requires that the model file be in a format that loads into ModelIO with
 - one `MDLMesh`
 - where that mesh contains one vertex buffer of vertex info items
 - where every item starts with three Float32 values for the vertex position coordinates
 */
 func loadPointCloud(modelFile:URL) -> [POINT3D]?
{
  let asset = MDLAsset(url: modelFile)
    print(asset.boundingBox)
  guard
    let meshes = asset.childObjects(of: MDLMesh.self) as? [MDLMesh],
    meshes.count == 1,
    let firstMesh = meshes.last
    else {
      LogError("Could not load the 3D model file \(modelFile.lastPathComponent) because, when loaded into Model I/O, it does not contain exactly one top-level mesh. An MDLMesh object represents one or more 'vertex buffers,' buffers of per-vertex data such as position coordinates, normal vectors, texture coordinates, etc.." )
      return nil
  }

  var additionalMeshCount:Int = 0
  var shouldStop:ObjCBool = false
  firstMesh.enumerateChildObjects(of: MDLMesh.self,
                                  root: firstMesh,
                                  using: { (obj:MDLObject, _:UnsafeMutablePointer<ObjCBool>) in
                                    additionalMeshCount = additionalMeshCount + 1
                                    LogDebug("Found additional descendent mesh: \(obj)")
  },
                                  stopPointer: &shouldStop)

  guard additionalMeshCount == 0 else {
    LogError("Could not load this 3D model. Instead of containing one top-level mesh, it contains a mesh and a child mesh")
    return nil
  }

  // ensure there's one vertex buffer
  let buffers = firstMesh.vertexBuffers
    print(buffers)
  guard let firstBuffer = buffers.first
    else {
      LogError("Could not load the 3D model file \(modelFile.lastPathComponent) because this model loads as a single MDLMesh which does not contain exactly one vertex buffer. That may be because this 3D model file loaded into memory as structure of distinct vertex buffer arrays, where each vertex buffer contains its own kind of data -- e.g., one containing positions, the other containing normals, etc.. This tool is not setup to process that configuration. You might want to try specifying the desired in-memory representation or modifying to the desired in-memory representation by specifying an MDLVertexDescriptor at load time or mutating it on the mesh object at runtime.")
      return nil
  }

  // ensure it describes vertex position coordinates as expected
  guard
    let attsUnfiltered = firstMesh.vertexDescriptor.attributes as? [MDLVertexAttribute],
    // w/o this filtering, there's a surplus of invalid attributes. I don't know why.
    let atts = Optional.some(attsUnfiltered)?.filter({$0.format != MDLVertexFormat.invalid}),
    atts.count > 0,
    atts[0].bufferIndex == 0,
    atts[0].name == MDLVertexAttributePosition,
    atts[0].offset == 0,
    atts[0].format == MDLVertexFormat.float3,
    let layoutsUnfiltered = firstMesh.vertexDescriptor.layouts as? [MDLVertexBufferLayout],
    // w/o this filtering, there's sometimes a surplus of empty layouts. I don't know why.
    let layouts = Optional.some(layoutsUnfiltered)?.filter({$0.stride != 0}),
    layouts.count == 1,
    let stride = layouts.first?.stride

    else {
      LogError("Could not load the 3D Model file \(modelFile.lastPathComponent) because it does not load into Model I/O in a format where in its single vertexBuffer each buffer item is a structure whose the first component is an array of three Float32 values representing position coordinates.")
      return nil
  }

  // CPU-accessible reference to the memory in the the vertexBuffer
  let buffermap:MDLMeshBufferMap = firstBuffer.map()
  let rawBasePtr:UnsafeMutableRawPointer = buffermap.bytes

  // temporary function for returning a 3D point given its index in the vertex buffer
  func getPosition(_ i:Int) -> POINT3D {
    return rawBasePtr.load(fromByteOffset: stride * i, as: POINT3D.self)
  }

  /*
   We stride manually, instead of using an UnsafeBufferPointer, so we can
   determine the stride at runtime.
   */
  var positions = (0..<firstMesh.vertexCount).map(getPosition)

  // if the mesh has a transform, transform every position
  // (essentially a matrix mult of m * (3xn matrix with n column vectors)
  if let matrix = firstMesh.transform?.matrix
  {
    LogInfo("Found a transform matrix associated with this mesh: \(matrix). Applying it.")

    // transform all the vertex positions
    for i in 0..<positions.count {
      let old = positions[i]
      let oldfloat4 = float4.init(old.x, old.y, old.z, 1)
      let newfloat4 = matrix * oldfloat4
      let newP = POINT3D.init(x: newfloat4.x / newfloat4.w,
                              y: newfloat4.y / newfloat4.w,
                              z: newfloat4.z / newfloat4.w)
      positions[i] = newP
    }
  }

  return positions
}
