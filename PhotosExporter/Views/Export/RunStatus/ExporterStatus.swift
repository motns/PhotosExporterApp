//
//  RunStatusHeading.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 19/06/2025.
//

import SwiftUI
import PhotosExporterLib

@MainActor
struct ExporterStatus: View {
  var status: TaskStatus<PhotosExporterLib.Result>

  @Environment(PhotosExporterLibModel.self) var photosExporterLibModel

  var body: some View {
    GroupBox {
      HStack {
        TaskStatusIcon(
          status: status,
          font: .title2
        )

        Text("Photos Export")
          .foregroundColor(
            TaskStatusHelper.colorForStatus(status: status)
          )
          .font(.title2)

        TaskStatusLabel(status: status)

        Spacer()

        let isRunning = switch status {
        case .running: true
        default: false
        }

        Button {
          Task {
            await photosExporterLibModel.runExport()
          }
        } label: {
          Label("Run", systemImage: "play.circle")
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .disabled(isRunning)
      }
      .padding(5)
    }
  }
}

// TODO - Work out how not to leak this out of #Preview
struct ExporterStatusPreview: View {
  @State var modelOpt: PhotosExporterLibModel? = nil

  var body: some View {
    switch modelOpt {
    case .none:
      Text("Loading...")
        .padding(150)
        .task {
          modelOpt = await PreviewHelper.getPhotosExporterLibModel()
        }
    case .some(let model):
      Group {
        ExporterStatus(status: TaskStatus<PhotosExporterLib.Result>.notStarted)
          .environment(model)
        ExporterStatus(status: .running(nil))
          .environment(model)
        ExporterStatus(status: .failed("It is all on fire!"))
          .environment(model)
        ExporterStatus(status: .complete(
          PhotosExporterLib.Result.empty()
        )).environment(model)
      }
    }
  }
}

#Preview {
  ExporterStatusPreview()
}
