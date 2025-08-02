//
//  AppModel.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 23/06/2025.
//

import Foundation
import Logging
import LoggingOSLog
import PhotosExporterLib

@Observable
class AppModel {
  public private(set) var isAuthorised: Bool = true
  public private(set) var exportURL: URL?
  public private(set) var lastExportURL: URL?
  public private(set) var photosExporterLibModel: PhotosExporterLibModel?
  
  public private(set) var errorModal: (String, String)?
  public var showErrorModal: Bool {
    get {
      errorModal != nil
    }
    set {
      if !newValue {
        self.errorModal = nil
      }
    }
  }
  public let logger: Logger
  
  private let lastExportURLKey = "lastExportURL"
  
  init() {
    var logger = Logger(label: "io.motns.PhotosExporter")
    logger.logLevel = .debug
    logger.handler = LoggingOSLog.init(label: logger.label)
    self.logger = logger
    
    UserDefaults.standard.removeObject(forKey: "NSWindow Frame Main Window")
  }
  
  deinit {
    self.exportURL?.stopAccessingSecurityScopedResource()
  }
  
  func setError(title: String, message: String) {
    self.errorModal = (title, message)
  }
  
  @MainActor
  func authorise() async {
    do {
      try await PhotosExporterLib.authorisePhotos()
      isAuthorised = true
    } catch {
      setError(title: "Unauthorised", message: "\(error)")
    }
  }

  func setExportURL(_ exportURL: URL) {
    UserDefaults.standard.set(exportURL, forKey: lastExportURLKey)
    self.lastExportURL = exportURL
    self.exportURL = exportURL
  }

  func clearExportURL() {
    self.exportURL = nil
    self.photosExporterLibModel = nil
  }
  
  @MainActor
  func initExporter() async {
    do {
      if let exportURL = self.exportURL {
        if !exportURL.startAccessingSecurityScopedResource() {
          self.logger.warning("Failed to access security scope for export URL: \(exportURL)")
          // We'll continue here anyway, because this doesn't always signal a failure
        }
        let photosExporter = try await PhotosExporterLib.create(exportBaseDir: exportURL)
        self.photosExporterLibModel = try PhotosExporterLibModel(
          appModel: self,
          photosExporter: photosExporter,
        )
      } else {
        self.logger.warning("initExporter called with no export URL set")
      }
    } catch {
      self.logger.error("Failed to initialize exporter: \(error)")
      setError(title: "Failed to initialize exporter", message: "\(error)")
      return
    }
  }
}
