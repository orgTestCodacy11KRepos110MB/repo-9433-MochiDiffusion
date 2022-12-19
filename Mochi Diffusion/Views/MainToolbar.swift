//
//  MainToolbar.swift
//  Mochi Diffusion
//
//  Created by Joshua Park on 12/19/22.
//

import SwiftUI

struct MainToolbar: View {
    @State private var isInfoPopoverShown = false
    var image: Binding<SDImage?>
    var copyToPrompt: () -> ()
    
    var body: some View {
        if let sdi = image.wrappedValue, let img = sdi.image {
            let imageView = Image(img, scale: 1, label: Text("generated"))
            Button(action: { self.isInfoPopoverShown.toggle() }) {
                Label("Get Info", systemImage: "info.circle")
            }
            .popover(isPresented: self.$isInfoPopoverShown, arrowEdge: .bottom) {
                InspectorView(image: image, copyToPrompt: self.copyToPrompt)
                    .padding()
            }
            Button(action: sdi.save) {
                Label("Save", systemImage: "square.and.arrow.down")
            }
            ShareLink(item: imageView, preview: SharePreview(sdi.prompt, image: imageView))
        }
        else {
            Button(action: {}) {
                Label("Get Info", systemImage: "info.circle")
            }
            .disabled(true)
            Button(action: {}) {
                Label("Save", systemImage: "square.and.arrow.down")
            }
            .disabled(true)
            Button(action: {}) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .disabled(true)
        }
    }
}

struct MainToolbar_Previews: PreviewProvider {
    static var previews: some View {
        var sd = SDImage()
        sd.prompt = "Test prompt"
        return MainToolbar(image: .constant(sd), copyToPrompt: {})
    }
}
