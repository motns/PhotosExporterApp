//
//  ExportStatus.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 18/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct ExportRun: View {
  let status: PhotosExporterLib.Status

  @State var expandAssetExporter: Bool = false
  @State var expandFileExporter: Bool = false
  
  var assetExporterRunning: Bool {
    switch status.assetExporterStatus.status {
    case .running: true
    default: false
    }
  }
  
  var fileExporterRunning: Bool {
    switch status.fileExporterStatus.status {
    case .running: true
    default: false
    }
  }
  
  var assetExporterShowSubtasks: Bool {
    expandAssetExporter || assetExporterRunning
  }
  
  var fileExporterShowSubtasks: Bool {
    expandFileExporter || fileExporterRunning
  }
  
  var body: some View {
    ScrollView {
      VStack {
        ExporterStatus(status: status.status)
        
        VStack {
          TaskStatusView(
            taskName: "Asset Exporter",
            status: status.assetExporterStatus.status,
            showSubtasks: assetExporterRunning ? nil : $expandAssetExporter,
          )
          if assetExporterShowSubtasks {
            VStack {
              TaskStatusView(
                taskName: "Export Assets",
                status: status.assetExporterStatus.exportAssetStatus,
                taskNameFont: .body,
                runStateFont: .caption,
              )
              TaskStatusView(
                taskName: "Mark Deleted Items",
                status: status.assetExporterStatus.markDeletedStatus,
                taskNameFont: .body,
                runStateFont: .caption,
              )
              TaskStatusView(
                taskName: "Remove Expired Items",
                status: status.assetExporterStatus.removeExpiredStatus,
                taskNameFont: .body,
                runStateFont: .caption,
              )
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .transition(.slide)
            .animation(.linear, value: assetExporterShowSubtasks)
          }
          
          TaskStatusView(
            taskName: "Collection Exporter",
            status: status.collectionExporterStatus,
          )
          
          TaskStatusView(
            taskName: "File Exporter",
            status: status.fileExporterStatus.status,
            showSubtasks: fileExporterRunning ? nil : $expandFileExporter,
          )
          if fileExporterShowSubtasks {
            VStack {
              TaskStatusView(
                taskName: "Copy",
                status: status.fileExporterStatus.copyStatus,
                taskNameFont: .body,
                runStateFont: .caption,
              )
              TaskStatusView(
                taskName: "Delete Removed",
                status: status.fileExporterStatus.deleteStatus,
                taskNameFont: .body,
                runStateFont: .caption,
              )
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .transition(.slide)
            .animation(.linear, value: fileExporterShowSubtasks)
          }
          
          TaskStatusView(
            taskName: "Symlink Creator",
            status: status.symlinkCreatorStatus,
          )
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        Spacer()
      }
      .padding()
    }
    .frame(minWidth: 750, minHeight: 500)
  }
}

struct ExportRunPreview: View {
  @State var modelOpt: PhotosExporterLibModel? = nil
  @State var appModel: AppModel = PreviewHelper.getAppModel()
  var status: PhotosExporterLib.Status

  var body: some View {
    switch modelOpt {
    case .none:
      Text("ExportRunPreview...")
        .task {
          await appModel.initExporter()
          modelOpt = appModel.photosExporterLibModel
        }
        .frame(minWidth: 750, minHeight: 500)
    case .some(let model):
      ExportRun(status: status)
        .environment(model)
        .environment(appModel)
    }
  }
}


#Preview("Not Running") {
  let status = PhotosExporterLib.Status(
    status: .notStarted,
    assetExporterStatus: AssetExporterStatus.notStarted(),
    collectionExporterStatus: .notStarted,
    fileExporterStatus: FileExporterStatus.notStarted(),
    symlinkCreatorStatus: .notStarted,
  )

  ExportRunPreview(status: status)
}

#Preview("Exporter Running") {
//  let assetExporterStatus = TestData.AssetExporter.started(
//    exportAssetStatus: TestData.RunStatusWithProgress.progress(progress: 0.45)
//  )
//  let runStatus = TestData.PhotosExporter.started(
//    assetExporterStatus: assetExporterStatus,
//    collectionExporterStatus: CollectionExporterStatus(),
//    fileExporterStatus: FileExporterStatus(),
//    symlinkCreatorStatus: SymlinkCreatorStatus(),
//  )
  
  let status = PhotosExporterLib.Status(
    status: .running(nil),
    assetExporterStatus: AssetExporterStatus(
      status: .running(nil),
      exportAssetStatus: .running(TaskProgress(toProcess: 100, processed: 27)),
      markDeletedStatus: .notStarted,
      removeExpiredStatus: .notStarted,
    ),
    collectionExporterStatus: .notStarted,
    fileExporterStatus: FileExporterStatus.notStarted(),
    symlinkCreatorStatus: .notStarted,
  )

  ExportRunPreview(status: status)
}
