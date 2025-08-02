//
//  LoadingScreen.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 15/06/2025.
//

import SwiftUI

struct LoadingScreen: View {
  var body: some View {
    HStack {
      Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.camera")
        .symbolEffect(.rotate.byLayer, options: .repeat(.continuous).speed(1.5))
        .symbolRenderingMode(.palette)
        .foregroundStyle(.white, .blue)
        .font(.largeTitle)
      Text("Initialising...")
        .font(.title2)
    }
    .padding()
    .frame(width: 200, height: 60)
  }
}

#Preview {
  LoadingScreen()
}
