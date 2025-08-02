//
//  Authorisation.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 17/06/2025.
//
import SwiftUI

struct Authorisation: View {
  var body: some View {
    HStack {
      Image(systemName: "lock.rotation")
        .symbolEffect(.rotate.byLayer, options: .repeat(.continuous).speed(1.5))
        .symbolRenderingMode(.palette)
        .foregroundStyle(.white, .blue)
        .font(.largeTitle)
      Text("Waiting for authorisation...")
        .font(.title2)
    }
    .padding()
    .frame(width: 300, height: 90)
  }
}

#Preview {
  Authorisation()
}
