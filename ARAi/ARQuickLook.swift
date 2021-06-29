//
//  ARQuickLook.swift
//  Model
//
//  Created by Andreas on 6/14/21.
//

import UIKit
import QuickLook
import ARKit
import SwiftUI
import SwiftUI
import QuickLook
import ARKit

struct ARQuickLookView: UIViewControllerRepresentable {
    // Properties: the file name (without extension), and whether we'll let
    // the user scale the preview content.
    @Binding var item: Item
    @Binding var isLocal: Bool
    @Binding var reload: Bool
    
    var allowScaling: Bool = true
    
    func makeCoordinator() -> ARQuickLookView.Coordinator {
        // The coordinator object implements the mechanics of dealing with
        // the live UIKit view controller.
        Coordinator(self)
    }
        
    func makeUIViewController(context: Context) -> QLPreviewController {
        // Create the preview controller, and assign our Coordinator class
        // as its data source.
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
       
        return controller
    }
    func getDocumentsDirectory() -> URL {
            // find all possible documents directories for this user
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
            // just send back the first one, which ought to be the only one
            return paths[0]
        }
    func updateUIViewController(_ controller: QLPreviewController,
                                context: Context) {
        // nothing to do here
    }
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let parent: ARQuickLookView
        private lazy var fileURL: URL = Bundle.main.url(forResource: parent.item.name,
                                                        withExtension: "reality")!
        
        init(_ parent: ARQuickLookView) {
            self.parent = parent
            super.init()
        }
        
        // The QLPreviewController asks its delegate how many items it has:
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        // For each item (see method above), the QLPreviewController asks for
        // a QLPreviewItem instance describing that item:
        func previewController(
            _ controller: QLPreviewController,
            previewItemAt index: Int
        ) -> QLPreviewItem {
            
            var fileURL = parent.getDocumentsDirectory().appendingPathComponent("\(parent.item.id).usdz")
            
            var item = ARQuickLookPreviewItem.init(fileAt: fileURL)
            
                
            if !parent.isLocal {
               
                fileURL = Bundle.main.url(forResource: parent.item.name, withExtension: "reality")!
            
            }
            
             item = ARQuickLookPreviewItem(fileAt: fileURL)
                item.allowsContentScaling = self.parent.allowScaling
              
            
            return item
        }
    }
   
}
