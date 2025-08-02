//
//  ContentView.swift
//  PhotosExporterApp
//
//  Created by Adam Borocz on 12/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct ContentView: View {
  @Environment(AppModel.self) var appModel

  var body: some View {
    if !appModel.isAuthorised {
      Authorisation()
        .task {
          await appModel.authorise()
        }
    } else {
      if appModel.exportURL != nil {
        if let photosExporterLibModel = appModel.photosExporterLibModel {
          ExportLayout()
            .environment(photosExporterLibModel)
        } else {
          LoadingScreen()
            .task {
              await appModel.initExporter()
            }
        }
      } else {
        DirectorySelection()
      }
    }
  }
}

#Preview {
  ContentView()
    .environment(AppModel())
}
