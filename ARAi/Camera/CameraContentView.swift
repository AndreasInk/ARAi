/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The app's top-level view.
*/

import SwiftUI

/// This is the root view for the app.
struct CameraContentView: View {
    @ObservedObject var model: CameraViewModel

    var body: some View {
        ZStack {
            // Make the entire background black.
            Color.black.edgesIgnoringSafeArea(.all)
            CameraView(model: model)
        }
        // Force dark mode so the photos pop.
        .environment(\.colorScheme, .dark)
    }
    
}

