//
//  ExportLayout.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 13/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct ExportLayout: View {
  @Environment(AppModel.self) var appModel
  @Environment(PhotosExporterLibModel.self) var photosExporterLibModel
  @State private var navSelectionId: ExporterNavItemId = .lastRun
  
  enum ExporterNavItemId {
    case lastRun, export, history
  }
  
  struct ExporterNavItem: Identifiable {
    let id: ExporterNavItemId
    let icon: String
    let label: String
  }
  
  let navItemList = [
    ExporterNavItem(
      id: .lastRun,
      icon: "info.circle",
      label: "Last Run",
    ),
    ExporterNavItem(
      id: .export,
      icon: "arrow.trianglehead.2.clockwise.rotate.90.camera",
      label: "Export",
    ),
    ExporterNavItem(
      id: .history,
      icon: "calendar",
      label: "History",
    ),
  ]

  var body: some View {
    NavigationSplitView {
      List(selection: $navSelectionId) {
        ForEach(navItemList) { item in
          NavigationLink(value: item.id) {
            HStack {
              Image(systemName: item.icon)
              Text(item.label)
            }
          }
        }

        Spacer()

        Button {
          appModel.clearExportURL()
        } label: {
          Label("Change Folder", systemImage: "xmark.square")
            .foregroundColor(.white)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
      }
      .frame(minWidth: 170)
    } detail: {
      switch navSelectionId {
      case .lastRun:
        LastRun(historyEntry: photosExporterLibModel.lastRun)
          .onAppear() {
            photosExporterLibModel.refreshLastRun()
          }
      case .export:
        ExportRun(status: photosExporterLibModel.status)
      case .history:
        ExportRunHistory(exportRunHistory: photosExporterLibModel.exportRunHistory)
          .onAppear() {
            photosExporterLibModel.refreshExportHistory()
          }
      }
    }
  }
}

struct ExportLayoutPreview: View {
  @State var modelOpt: PhotosExporterLibModel? = nil

  var body: some View {
    switch modelOpt {
    case .none:
      Text("Loading...")
        .task {
          modelOpt = await PreviewHelper.getPhotosExporterLibModel()
        }
    case .some(let model):
      ExportLayout().environment(model)
    }
  }
}

#Preview {
  ExportLayoutPreview()
}
