//
//  PhotosExporterAppApp.swift
//  PhotosExporterApp
//
//  Created by Adam Borocz on 12/06/2025.
//

import SwiftUI

@main
struct PhotosExporterApp: App {
  @State private var appModel = AppModel()

  var body: some Scene {
    Window("Exporter", id: "exporter") {
      ContentView()
        .environment(appModel)
        .alert(
          appModel.errorModal?.0 ?? "",
          isPresented: $appModel.showErrorModal,
        ) {
          Button("Ok", role: .cancel) {}
            .buttonStyle(.borderedProminent)
        } message: {
          Text(appModel.errorModal?.1 ?? "")
        }
    }
    .windowResizability(.contentSize)
  }
}
