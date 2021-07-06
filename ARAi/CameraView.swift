/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that displays the camera image and capture button.
*/
import Foundation
import SwiftUI
import AVKit

/// This is the app's primary view. It contains a preview area, a capture button, and a thumbnail view
/// showing the most recenty captured image.
struct CameraView: View {
    static let buttonBackingOpacity: CGFloat = 0.15
    
    @StateObject var model = CameraViewModel()
    @State private var showInfo: Bool = true
    let aspectRatio: CGFloat = 4.0 / 3.0
    let previewCornerRadius: CGFloat = 15.0
    @ObservedObject var userData: UserData
    @Binding var camera: Bool
    @State var useless = false
    @State var show = false
    @State var instruct = true
    var body: some View {
        NavigationView {
            GeometryReader { geometryReader in
                // Place the CameraPreviewView at the bottom of the stack.
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                        .onAppear() {
                            //camera = false
                           // instruct = true
                            //choosenFolder = model.captureDir ?? Bundle.main.url(forResource: "Banana", withExtension: "reality")!
                        }
                    // Center the preview view vertically. Place a clip frame
                    // around the live preview and round the corners.
                    VStack {
                        Spacer()
                            
                        CameraPreviewView(session: model.session)
                            .frame(width: geometryReader.size.width,
                                   height: geometryReader.size.width * aspectRatio,
                                   alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: previewCornerRadius))
                            .onAppear { model.startSession() }
                            .onDisappear { model.pauseSession() }
                            .overlay(
                                Image("ObjectReticle")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.all))
                        
                        Spacer()
                    }
                    
                    VStack {
                        // The app shows this view when showInfo is true.
                        ScanToolbarView(model: model, showInfo: $showInfo).padding(.horizontal)
                        if showInfo {
                            InfoPanelView(model: model)
                                .padding(.horizontal).padding(.top)
                        }
                        Spacer()
                        CaptureButtonPanelView(model: model, userData: userData, width: geometryReader.size.width)
                    } .padding()
                }
            }
            .navigationTitle(Text("Scan"))
            .navigationBarTitle("Scan")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $instruct) {
                OnboardingView(onboardingViews: [Onboarding(id: UUID(), image: "scan", title: "Photo Time!", description: "Take photos of an object with each photo overlapping and from various angles."), Onboarding(id: UUID(), image: "ob3", title: "Photo Time!", description: "Ensure that the only object you want scanned is visable to your camera, not any other object."), Onboarding(id: UUID(), image: "ob2", title: "Photo Time!", description: "Please allow for plenty of lighting and avoid see through objects."), Onboarding(id: UUID(), image: "up", title: "Upload Your Photos", description: "Once you've taken at least 20 photos, tap the photo preview in the bottom left, then tap upload and follow the instructions on the next view.")],isOnboarding: $instruct, isOnboarding2: $instruct, userData: userData)
                    .onChange(of: instruct) { value in
                        userData.instruct = value
                    }
            }
          
        }
      
    }
}

/// This view displays the image thumbnail, capture button, and capture mode button.
struct CaptureButtonPanelView: View {
    @ObservedObject var model: CameraViewModel
    @ObservedObject var userData: UserData
    /// This property stores the full width of the bar. The view uses this to place items.
    var width: CGFloat
    @State var animate = false
    var body: some View {
        // Add the bottom panel, which contains the thumbnail and capture button.
        ZStack(alignment: .center) {
            HStack {
                ThumbnailView(model: model, userData: userData)
                    .frame(width: width / 3)
                   
                Spacer()
            }
            HStack {
                Spacer()
                CaptureButton(model: model)
                Spacer()
            }
            HStack {
                Spacer()
                CaptureModeButton(model: model,
                                  frameWidth: width / 3)
                 
               
               
            }
           // HStack {
                
               // Spacer()
//            Button(action: {
//                withAnimation(.easeInOut(duration: 0.5)) {
//                    animate.toggle()
//                }
//                do {
//                let videoDeviceInputOld = try AVCaptureDeviceInput(
//                    device: model.front ? model.getVideoDeviceForPhotogrammetry() :  model.getVideoDeviceForPhotogrammetryFront())
//
//                model.front.toggle()
//
//                    let videoDeviceInput = try AVCaptureDeviceInput(
//                        device: model.front ? model.getVideoDeviceForPhotogrammetryFront() : model.getVideoDeviceForPhotogrammetry())
//
//                    model.session.removeInput(model.videoDeviceInput!)
//
//                    if model.session.canAddInput(videoDeviceInput) {
//
//                        model.session.addInput(videoDeviceInput)
//                        model.videoDeviceInput = videoDeviceInput
//                    } else {
//                      //  logger.error("Couldn't add video device input to the session.")
//                      //  setupResult = .configurationFailed
//                        return
//                    }
//                } catch {
//                   // logger.error("Couldn't create video device input: \(String(describing: error))")
//                    //setupResult = .configurationFailed
//                    return
//                }
//            }) {
//                Image(systemName: "camera")
//                    .font(.largeTitle)
//                    .foregroundColor(Color.white)
//
//                    .cornerRadius(5)
//                    .rotation3DEffect(.degrees(animate ? 180 : 360), axis: (x: 0, y:  1, z: 0))
//
//            }
                
           // }
        }  .padding(.horizontal)
    }
}

/// This is a custom "toolbar" view the app displays at the top of the screen. It includes the current capture
/// status and buttons for help and detailed information. The user can tap the entire top panel to
/// open or close the information panel.
struct ScanToolbarView: View {
    @ObservedObject var model: CameraViewModel
    @Binding var showInfo: Bool
    @State var isImporting = false
  
    var body: some View {
        ZStack {
            HStack {
                SystemStatusIcon(model: model)
                Button(action: {
                    print("Pressed Info!")
                    withAnimation {
                        showInfo.toggle()
                    }
                }, label: {
                    Image(systemName: "info.circle").foregroundColor(Color.blue)
                })
                Spacer()
                NavigationLink(destination: HelpPageView()) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(Color.blue)
                }
               
//                Button(action: {
//                    isImporting = true
//                }) {
//                    Image(systemName: "arrow.down.square")
//                        .padding()
//                }
            }
            
            if showInfo {
                Text("Current Capture Info")
                    .font(.caption)
                    .onTapGesture {
                        print("showInfo toggle!")
                        withAnimation {
                            showInfo.toggle()
                        }
                    }
            }
                
        }
       
                }
 
    let imageSuffix: String = ".HEIC"
    func imageUrl(in captureDir: URL, id: UInt32) -> URL {
        return captureDir.appendingPathComponent(CaptureInfo.photoIdString(for: id).appending(imageSuffix))
    }
    private func writeImage(to captureDir: URL, photo: UIImage, id: UInt32) -> Bool {
        let imageUrl = CaptureInfo.imageUrl(in: captureDir, id: id)
        print("Saving: \(imageUrl.path)...")
        //logger.log("Depth Data = \(String(describing: photo.depthData))")
        do {
            try photo.pngData()!
                .write(to: URL(fileURLWithPath: imageUrl.path))
            return true
        } catch {
          //  logger.error("Can't write image to \"\(imageUrl.path)\" error=\(String(describing: error))")
            return false
        }
    }
}

/// This capture button view is modeled after the Camera app button. The view changes shape when the
/// user starts shooting in automatic mode.
struct CaptureButton: View {
    static let outerDiameter: CGFloat = 80
    static let strokeWidth: CGFloat = 4
    static let innerPadding: CGFloat = 10
    static let innerDiameter: CGFloat = CaptureButton.outerDiameter -
        CaptureButton.strokeWidth - CaptureButton.innerPadding
    static let rootTwoOverTwo: CGFloat = CGFloat(2.0.squareRoot() / 2.0)
    static let squareDiameter: CGFloat = CaptureButton.innerDiameter * CaptureButton.rootTwoOverTwo -
        CaptureButton.innerPadding
    
    @ObservedObject var model: CameraViewModel
    
    init(model: CameraViewModel) {
        self.model = model
    }
    
    var body: some View {
        Button(action: {
            model.captureButtonPressed()
        }, label: {
            if model.isAutoCaptureActive {
                AutoCaptureButtonView(model: model)
            } else {
                ManualCaptureButtonView()
            }
        }).disabled(!model.isCameraAvailable || !model.readyToCapture)
    }
}

/// This is a helper view for the `CaptureButton`. It implements the shape for automatic capture mode.
struct AutoCaptureButtonView: View {
    @ObservedObject var model: CameraViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.red)
                .frame(width: CaptureButton.squareDiameter,
                       height: CaptureButton.squareDiameter,
                       alignment: .center)
                .cornerRadius(5)
            TimerView(model: model, diameter: CaptureButton.outerDiameter)
        }
    }
}

/// This is a helper view for the `CaptureButton`. It implements the shape for manual capture mode.
struct ManualCaptureButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white, lineWidth: CaptureButton.strokeWidth)
                .frame(width: CaptureButton.outerDiameter,
                       height: CaptureButton.outerDiameter,
                       alignment: .center)
            Circle()
                .foregroundColor(Color.white)
                .frame(width: CaptureButton.innerDiameter,
                       height: CaptureButton.innerDiameter,
                       alignment: .center)
        }
    }
}

struct CaptureModeButton: View {
    static let toggleDiameter = CaptureButton.outerDiameter / 3.0
    static let backingDiameter = CaptureModeButton.toggleDiameter * 2.0
    
    @ObservedObject var model: CameraViewModel
    var frameWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .center/*@END_MENU_TOKEN@*/, spacing: 2) {
            Button(action: {
                withAnimation {
                    model.advanceToNextCaptureMode()
                }
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: CaptureModeButton.backingDiameter,
                               height: CaptureModeButton.backingDiameter)
                        .foregroundColor(Color.white)
                        .opacity(Double(CameraView.buttonBackingOpacity))
                    Circle()
                        .frame(width: CaptureModeButton.toggleDiameter,
                               height: CaptureModeButton.toggleDiameter)
                        .foregroundColor(Color.white)
                    switch model.captureMode {
                    case .automatic:
                        Text("A").foregroundColor(Color.black)
                            .frame(width: CaptureModeButton.toggleDiameter,
                                   height: CaptureModeButton.toggleDiameter,
                                   alignment: .center)
                    case .manual:
                        Text("M").foregroundColor(Color.black)
                            .frame(width: CaptureModeButton.toggleDiameter,
                                   height: CaptureModeButton.toggleDiameter,
                                   alignment: .center)
                    }
                }
            })
            if case .automatic = model.captureMode {
                Text("Auto Capture")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .transition(.opacity)
            }
        }
        // This frame centers the view and keeps it from reflowing when the view has a caption.
        // The view uses .top so the button won't move and the text will animate in and out.
        .frame(width: frameWidth, height: CaptureModeButton.backingDiameter, alignment: .top)
    }
}

/// This view shows a thumbnail of the last photo captured, similar to the  iPhone's Camera app. If there isn't
/// a previous photo, this view shows a placeholder.
struct ThumbnailView: View {
    private let thumbnailFrameWidth: CGFloat = 60.0
    private let thumbnailFrameHeight: CGFloat = 60.0
    private let thumbnailFrameCornerRadius: CGFloat = 10.0
    private let thumbnailStrokeWidth: CGFloat = 2
    
    @ObservedObject var model: CameraViewModel
    @ObservedObject var userData: UserData
    @State var categories = [Category(id: UUID(), name: "", description: "", items: [Item](), colors: ["purple", "blue"])]
    
    init(model: CameraViewModel, userData: UserData) {
        self.model = model
        self.userData = userData
       
    }
    
    var body: some View {
       
        NavigationLink(destination: CaptureGalleryView(model: model, userData: userData)) {
            if let capture = model.lastCapture {
                if let preview = capture.previewUiImage {
                    ThumbnailImageView(uiImage: preview,
                                       width: thumbnailFrameWidth,
                                       height: thumbnailFrameHeight,
                                       cornerRadius: thumbnailFrameCornerRadius,
                                       strokeWidth: thumbnailStrokeWidth)
                } else {
                    // Use full-size if no preview.
                    ThumbnailImageView(uiImage: capture.uiImage,
                                       width: thumbnailFrameWidth,
                                       height: thumbnailFrameHeight,
                                       cornerRadius: thumbnailFrameCornerRadius,
                                       strokeWidth: thumbnailStrokeWidth)
                }
            } else {  // When no image, use icon from the app bundle.
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(16)
                    .frame(width: thumbnailFrameWidth, height: thumbnailFrameHeight)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: thumbnailFrameCornerRadius)
                            .fill(Color.white)
                            .opacity(Double(CameraView.buttonBackingOpacity))
                            .frame(width: thumbnailFrameWidth,
                                   height: thumbnailFrameWidth,
                                   alignment: .center)
                    )
            }
        }
    }
}

struct ThumbnailImageView: View {
    var uiImage: UIImage
    var thumbnailFrameWidth: CGFloat
    var thumbnailFrameHeight: CGFloat
    var thumbnailFrameCornerRadius: CGFloat
    var thumbnailStrokeWidth: CGFloat
    
    init(uiImage: UIImage, width: CGFloat, height: CGFloat, cornerRadius: CGFloat,
         strokeWidth: CGFloat) {
        self.uiImage = uiImage
        self.thumbnailFrameWidth = width
        self.thumbnailFrameHeight = height
        self.thumbnailFrameCornerRadius = cornerRadius
        self.thumbnailStrokeWidth = strokeWidth
    }
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: thumbnailFrameWidth, height: thumbnailFrameHeight)
            .cornerRadius(thumbnailFrameCornerRadius)
            .clipped()
            .overlay(RoundedRectangle(cornerRadius: thumbnailFrameCornerRadius)
                        .stroke(Color.primary, lineWidth: thumbnailStrokeWidth))
            .shadow(radius: 10)
    }
}
import SwiftUI
import UniformTypeIdentifiers

struct InputDoument: FileDocument {

    static var readableContentTypes: [UTType] { [.folder] }

    var input: Data

    init(input: Data) {
        self.input = input
    }

    init(configuration: FileDocumentReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
            
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
     input = data
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: input)
    }

}
