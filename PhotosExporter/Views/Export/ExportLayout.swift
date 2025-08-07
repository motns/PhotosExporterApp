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
    VStack(spacing: 0) {
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
        }
        .frame(minWidth: 150)
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
      
      GroupBox {
        HStack {
          Label("Folder:", systemImage: "folder").bold()
          Text(appModel.exportURL?.path ?? "Not set")

          Spacer()
          
          Button {
            appModel.clearExportURL()
          } label: {
            Label("Change", systemImage: "xmark.circle")
              .foregroundColor(.white)
          }
          .buttonStyle(.borderedProminent)
          .controlSize(.large)
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
      }
    }
    .frame(minWidth: 900, minHeight: 600)
  }
}

struct ExportLayoutPreview: View {
  @State var modelOpt: PhotosExporterLibModel? = nil
  @State var appModel: AppModel = PreviewHelper.getAppModel()

  var body: some View {
    switch modelOpt {
    case .none:
      Text("ExportLayoutPreview...")
        .task {
          await appModel.initExporter()
          modelOpt = appModel.photosExporterLibModel
        }
        .frame(minWidth: 1000, minHeight: 700)
    case .some(let model):
      ExportLayout()
        .environment(model)
        .environment(appModel)
    }
  }
}

#Preview {
  ExportLayoutPreview()
}
