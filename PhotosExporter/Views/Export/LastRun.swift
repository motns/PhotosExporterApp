//
//  LastRun.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 18/06/2025.
//

import Foundation
import SwiftUI
import PhotosExporterLib

struct LastRun: View {
  var historyEntry: HistoryEntry?
  
  func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return formatter.string(from: date)
  }
  
  var body: some View {
    if let historyEntry {
      RunHistoryEntryView(historyEntry: historyEntry)
    } else {
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
    }
  }
}

#Preview("Empty") {
  LastRun(historyEntry: nil)
}

#Preview("NonEmpty") {
  let historyEntry = HistoryEntry(
    id: "123",
    createdAt: Date(),
    exportResult: PhotosExporterLib.Result.empty(),
    assetCount: 100,
    fileCount: 110,
    albumCount: 10,
    folderCount: 5,
    fileSizeTotal: 123456789,
    runTime: Decimal(string: "45.67")!,
  )
  LastRun(historyEntry: historyEntry)
}
