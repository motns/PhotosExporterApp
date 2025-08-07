//
//  ExportRunHistory.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 18/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct ExportRunHistory: View {
  let exportRunHistory: [HistoryEntry]

  @State var historyRowExpanded: [String: Bool]

  init(exportRunHistory: [HistoryEntry]) {
    var historyRowExpanded: [String: Bool] = [:]
    exportRunHistory.forEach { historyRowExpanded[$0.id] = false }
    self._historyRowExpanded = State(initialValue: historyRowExpanded)

    self.exportRunHistory = exportRunHistory
  }

  var body: some View {
    if exportRunHistory.isEmpty {
      VStack {
        Spacer()
        HStack {
          Spacer()
          Image(systemName: "questionmark.circle.dashed")
          Text("Export hasn't been run yet")
          Spacer()
        }
        Spacer()
      }
      .padding()
    } else {
      List(exportRunHistory, id: \.id) { entry in
        GroupBox {
          HStack {
            Label("Exported At:", systemImage: "calendar.badge.clock").bold()
            Text("\(DateHelper.formatDate(entry.createdAt))")

            Spacer()

            Button {
              if historyRowExpanded[entry.id] == nil {
                historyRowExpanded[entry.id] = false
              }
              historyRowExpanded[entry.id]?.toggle()
            } label: {
              Label("Subtasks", systemImage: "chevron.right.circle")
                .labelStyle(.iconOnly)
                .imageScale(.large)
                .rotationEffect(.degrees((historyRowExpanded[entry.id] ?? false) ? 90 : 0))
                .scaleEffect((historyRowExpanded[entry.id] ?? false) ? 1.2 : 1)
                .animation(.easeInOut(duration: 0.2), value: (historyRowExpanded[entry.id] ?? false))
            }
            .buttonStyle(.borderless)
          }
        }
        
        if historyRowExpanded[entry.id] ?? false {
          GroupBox {
            RunHistoryEntryView(historyEntry: entry)
          }
          .padding(.leading, 15)
          .padding(.trailing, 15)
        }
      }
      .foregroundColor(.primary)
      .frame(minWidth: 750, minHeight: 500)
    }
  }
}

#Preview("Empty") {
  ExportRunHistory(exportRunHistory: [])
}

#Preview("Non Empty") {
  let historyEntry1 = HistoryEntry(
    id: "123",
    createdAt: Date(),
    exportResult: PhotosExporterLib.Result.empty(),
    assetCount: 100,
    fileCount: 110,
    albumCount: 10,
    folderCount: 5,
    fileSizeTotal: 123456789,
    runTime: Decimal(string: "98.67")!,
  )
  let historyEntry2 = HistoryEntry(
    id: "456",
    createdAt: Date(),
    exportResult: PhotosExporterLib.Result.empty(),
    assetCount: 100,
    fileCount: 110,
    albumCount: 10,
    folderCount: 5,
    fileSizeTotal: 123456789,
    runTime: Decimal(string: "45.67")!,
  )
  let historyEntry3 = HistoryEntry(
    id: "789",
    createdAt: Date(),
    exportResult: PhotosExporterLib.Result.empty(),
    assetCount: 100,
    fileCount: 110,
    albumCount: 10,
    folderCount: 5,
    fileSizeTotal: 123456789,
    runTime: Decimal(string: "36.67")!,
  )
  ExportRunHistory(
    exportRunHistory: [historyEntry1, historyEntry2, historyEntry3]
  )
}
