//
//  RunHistoryEntry.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 22/06/2025.
//

import SwiftUI
import Foundation
import PhotosExporterLib

struct RunHistoryEntryView: View {
  let historyEntry: HistoryEntry
  
  var body: some View {
    VStack {
      GroupBox() {
        VStack {
          HStack{
            Label("Assets:", systemImage: "photo").bold()
            Text("\(historyEntry.assetCount)")
            Spacer()
            
            Label("Files:", systemImage: "document").bold()
            Text("\(historyEntry.fileCount)")
            Spacer()
            
            Label("Albums:", systemImage: "photo.stack").bold()
            Text("\(historyEntry.albumCount)")
            Spacer()
            
            Label("Folders:", systemImage: "folder").bold()
            Text("\(historyEntry.folderCount)")
            Spacer()
          }
          .padding(.bottom, 10)
          
          HStack {
            Label("Exported At:", systemImage: "calendar.badge.clock").bold()
            Text("\(DateHelper.formatDate(historyEntry.createdAt))")
            Spacer()

            Label("Storage Size:", systemImage: "internaldrive").bold()
            Text("\(ByteCountFormatter().string(fromByteCount: historyEntry.fileSizeTotal))")
            Spacer()
            
            Label("Run Time:", systemImage: "stopwatch").bold()
            Text("\(historyEntry.runTime)s")
            Spacer()
          }
        }
      } label: {
        Label("Export Summary", systemImage: "chart.xyaxis.line")
          .font(.title3)
          .padding(.bottom, 5)
      }
      .padding(.bottom, 10)
      
      AssetExporterResultView(result: historyEntry.exportResult.assetExport)
        .padding(.bottom, 10)
      
      CollectionExporterResultView(result: historyEntry.exportResult.collectionExport)
      
      Spacer()
    }
    .padding()
  }
}

#Preview {
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
  RunHistoryEntryView(historyEntry: historyEntry)
}
