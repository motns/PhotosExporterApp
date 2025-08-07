//
//  PreviewHelper.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 19/06/2025.
//

import Foundation

enum PreviewHelper {
  @MainActor
  static func getAppModel() -> AppModel {
    let testFolderURL = URL(filePath: NSHomeDirectory()).appending(path: "export_test")
    let appModel = AppModel()
    appModel.setExportURL(testFolderURL)
    return appModel
  }

  @MainActor
  static func getPhotosExporterLibModel() async -> PhotosExporterLibModel {
    let testFolderURL = URL(filePath: NSHomeDirectory()).appending(path: "export_test")
    let appModel = AppModel()
    appModel.setExportURL(testFolderURL)
    await appModel.initExporter()
    return appModel.photosExporterLibModel!
  }
}
