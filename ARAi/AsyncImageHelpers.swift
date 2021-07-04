/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A helper class that loads a single image and its corresponding thumbnail
 in the background.
*/

import AVFoundation
import Combine
import Foundation
import SwiftUI

/// This class handles image loading for a single image and its corresponding thumbnail. It loads images
/// asynchronously in the background and publishes to Combine when it finishes loading a file, or if it
/// encounters an error while loading.
class AsyncImageStore: ObservableObject {
    var url: URL
    
    /// When the store finishes loading the thumbnail, this property contains the thumbnail. If the store
    /// hasn't finished loading the thumbnail, this property contains a placeholder image.
    @Published var thumbnailImage: UIImage
    
    /// When the store is finished loading the full-size image, this property contains the full-size image. If
    /// the store hasn't finished loading the full-size image, this property contains a placeholder image.
    @Published var image: UIImage
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let errorImage: UIImage
    
    /// This initializes a data store object that loads a specified image and its corresponding thumbnail.
    /// When the store begins loading images, it publishes `loadingImage`. If the store fails to load
    /// the thumbnail or image, it publishes `errorImage`. The store doesn't start loading an image
    /// until the first time your code accesses one of the image properties.
    init(url: URL, loadingImage: UIImage = UIImage(systemName: "questionmark.circle")!,
         errorImage: UIImage = UIImage(systemName: "xmark.circle")!) {
        self.url = url
        self.thumbnailImage = loadingImage
        self.image = loadingImage
        self.errorImage = errorImage
    }
    
    /// This method starts an asynchronous load of the thumbnail image. If this method doesn't find an
    /// image at the specified URL, it publishes an error image.
    func loadThumbnail() {
        ImageLoader.loadThumbnail(url: url)
            .receive(on: DispatchQueue.main)
            .replaceError(with: errorImage)
            .assign(to: \.thumbnailImage, on: self)
            .store(in: &subscriptions)
    }
    
    /// This method starts an asynchronous load of the full-size image. If it doesn't find an image at the
    /// specified URL, it publishes an error image.
    func loadImage() {
        ImageLoader.loadImage(url: url)
            .receive(on: DispatchQueue.main)
            .replaceError(with: errorImage)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
    }
}

/// This view displays a thumbnail from a URL. It begins loading the thumbnail asynchronously when
/// it first appears on screen. While loading, this view displays a placeholder image. If it encounters an error,
/// it displays an error image. You must call the `load()` function to start asynchronous loading.
struct AsyncThumbnailView: View {
    let url: URL
    
    @StateObject private var imageStore: AsyncImageStore
    
    init(url: URL) {
        self.url = url
        
        // Initialize the image store with the provided URL.
        _imageStore = StateObject(wrappedValue: AsyncImageStore(url: url))
    }
    
    var body: some View {
        Image(uiImage: imageStore.thumbnailImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .onAppear() {
                imageStore.loadThumbnail()
            }
    }
}
import CropImageView
struct AsyncImageView: View {
    let url: URL
    @StateObject private var imageStore: AsyncImageStore
    @State var showCropView = false
    @State private var currentPositionTopLeft: CGPoint = .zero
       @State private var newPositionTopLeft: CGPoint = .zero

       @State private var currentPositionTopRight: CGPoint = .zero
       @State private var newPositionTopRight: CGPoint = .zero

       @State private var currentPositionBottomLeft: CGPoint = .zero
       @State private var newPositionBottomLeft: CGPoint = .zero

       @State private var currentPositionBottomRight: CGPoint = .zero
       @State private var newPositionBottomRight: CGPoint = .zero
    init(url: URL) {
        self.url = url
        
        _imageStore = StateObject(wrappedValue: AsyncImageStore(url: url))
    }
    
    var body: some View {
        VStack {
            Button(action: {
                //imageStore.image.crop(withPath: UIBezierPath(cgPath: <#T##CGPath#>), andColor: UIColor.clear)
                imageStore.image.ciImage?.cropped(to: CGRect(x: newPositionTopLeft.x, y: newPositionTopLeft.y, width: newPositionBottomRight.x, height: newPositionBottomRight.y))
                              }) {
                                  Image(systemName: "checkmark").resizable().frame(width: 24, height: 24)
                                  .padding(20)
                                  .background(Color(UIColor.systemBlue))
                                  .foregroundColor(Color.white)
                              }.clipShape(Circle())
                                  .shadow(radius: 4)
        Image(uiImage: imageStore.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(getCorners())
            .onAppear() {
                imageStore.loadImage()
            }
           
        
        } .scaleEffect(0.7)
    }
    private func getCorners() -> some View {

           return
           HStack {
               VStack {
                   ZStack {
                       CropImageViewRectangle(
                           currentPositionTopLeft: self.$currentPositionTopLeft,
                           currentPositionTopRight: self.$currentPositionTopRight,
                           currentPositionBottomLeft: self.$currentPositionBottomLeft,
                           currentPositionBottomRight: self.$currentPositionBottomRight
                       )

                       GeometryReader { geometry in
                           CropImageViewRectangleCorner(
                               currentPosition: self.$currentPositionTopLeft,
                               newPosition: self.$newPositionTopLeft,
                               displacementX: 0,
                               displacementY: 0
                           )

                           CropImageViewRectangleCorner(
                               currentPosition: self.$currentPositionTopRight,
                               newPosition: self.$newPositionTopRight,
                               displacementX: geometry.size.width/1.7,
                               displacementY: 0
                           )

                           CropImageViewRectangleCorner(
                               currentPosition: self.$currentPositionBottomLeft,
                               newPosition: self.$newPositionBottomLeft,
                               displacementX: 0,
                               displacementY: geometry.size.height/1.7
                           )

                           CropImageViewRectangleCorner(
                               currentPosition: self.$currentPositionBottomRight,
                               newPosition: self.$newPositionBottomRight,
                               displacementX: geometry.size.width/1.7,
                               displacementY: geometry.size.height/1.7
                           )
                       }
}
               }
               }
           }
}
struct CropImageViewRectangle: View {
    @Binding var currentPositionTopLeft: CGPoint
    @Binding var currentPositionTopRight: CGPoint
    @Binding var currentPositionBottomLeft: CGPoint
    @Binding var currentPositionBottomRight: CGPoint

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: self.currentPositionTopLeft)
                path.addLine(
                    to: .init(
                        x: self.currentPositionTopRight.x,
                        y: self.currentPositionTopRight.y
                    )
                )
                path.addLine(
                    to: .init(
                        x: self.currentPositionBottomRight.x,
                        y: self.currentPositionBottomRight.y
                    )
                )
                path.addLine(
                    to: .init(
                        x: self.currentPositionBottomLeft.x,
                        y: self.currentPositionBottomLeft.y
                    )
                )
                path.addLine(
                    to: .init(
                        x: self.currentPositionTopLeft.x,
                        y: self.currentPositionTopLeft.y
                    )
                )
            }
            .stroke(Color.blue, lineWidth: CGFloat(1))
        }
    }
}

struct CropImageViewRectangleCorner: View {
    @Binding var currentPosition: CGPoint
    @Binding var newPosition: CGPoint

    var displacementX: CGFloat
    var displacementY: CGFloat

    var body: some View {
        Circle().foregroundColor(Color.blue).frame(width: 24, height: 24)
        .offset(x: self.currentPosition.x, y: self.currentPosition.y)
        .gesture(DragGesture()
            .onChanged { value in
                self.currentPosition = CGPoint(x: value.translation.width + self.newPosition.x, y: value.translation.height + self.newPosition.y)
            }
            .onEnded { value in
                self.currentPosition = CGPoint(x: value.translation.width + self.newPosition.x, y: value.translation.height + self.newPosition.y)
                self.newPosition = self.currentPosition
            }
        )
        .opacity(0.5)
        .position(CGPoint(x: 0, y: 0))
        .onAppear() {
            if self.displacementX > 0 || self.displacementY > 0 {
                self.currentPosition = CGPoint(x: self.displacementX, y: self.displacementY)
                self.newPosition = self.currentPosition
            }
        }
    }
}
extension UIImage {

    func crop(withPath: UIBezierPath, andColor: UIColor) -> UIImage {
        let r: CGRect = withPath.cgPath.boundingBox
        UIGraphicsBeginImageContextWithOptions(r.size, false, self.scale)
        if let context = UIGraphicsGetCurrentContext() {
            let rect = CGRect(origin: .zero, size: size)
            context.setFillColor(andColor.cgColor)
            context.fill(rect)
            context.translateBy(x: -r.origin.x, y: -r.origin.y)
            context.addPath(withPath.cgPath)
            context.clip()
        }
        draw(in: CGRect(origin: .zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext()
        return image
    }

}
