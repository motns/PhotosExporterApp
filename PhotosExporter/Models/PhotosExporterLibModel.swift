//
//  PhotoExporterLibModel.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 16/06/2025.
//

import Foundation
import Logging
import LoggingOSLog
import PhotosExporterLib

@Observable
class PhotosExporterLibModel {
  public private(set) var lastRun: HistoryEntry?
  public private(set) var exportRunHistory: [HistoryEntry] = []
  public private(set) var status: PhotosExporterLib.Status
  
  private let photosExporter: PhotosExporterLib
  private let appModel: AppModel
  
  init(
    appModel: AppModel,
    photosExporter: PhotosExporterLib,
  ) throws {
    self.appModel = appModel
    self.photosExporter = photosExporter
    self.status = PhotosExporterLib.Status.notStarted()
  }

  @MainActor
  func runExport() async {
    do {
      for try await exporterStatus in photosExporter.export() {
        status = exporterStatus
      }
    } catch {
      appModel.setError(title: "Unexpected Error", message: "\(error)")
    }
  }

  func refreshLastRun() {
    do {
      lastRun = try photosExporter.lastRun()
    } catch {
      appModel.logger.error("Failed to fetch last run: \(error)")
      appModel.setError(title: "Failed to get Status", message: "Failed to fetch last run: \(error)")
    }
  }

  func refreshExportHistory() {
    do {
      exportRunHistory = try photosExporter.exportHistory()
    } catch {
      appModel.logger.error("Failed to fetch export history: \(error)")
      appModel.setError(title: "Failed to get History", message: "Failed to fetch export history: \(error)")
    }
  }
}
