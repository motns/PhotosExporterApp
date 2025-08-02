//
//  AssetExporterResult.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 22/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct AssetExporterResultView: View {
  let result: AssetExporterResult
  
  var body: some View {
    VStack {
      GroupBox() {
        VStack {
          HStack{
            Label("Inserted:", systemImage: "plus.circle").bold()
            Text("\(result.assetInserted)")
            Spacer()
            
            Label("Updated:", systemImage: "pencil.and.list.clipboard").bold()
            Text("\(result.assetUpdated)")
            Spacer()
            
            Label("Unchanged:", systemImage: "pencil.slash").bold()
            Text("\(result.assetUnchanged)")
            Spacer()

            Label("Skipped:", systemImage: "forward.end.circle").bold()
            Text("\(result.assetSkipped)")
            Spacer()
          }
          .padding(.bottom, 10)
          
          HStack{
            Label("Marked to Delete:", systemImage: "exclamationmark.triangle").bold()
            Text("\(result.assetMarkedForDeletion)")
            Spacer()
            
            Label("Deleted:", systemImage: "trash").bold()
            Text("\(result.assetDeleted)")
            Spacer()
          }
        }
      } label: {
        Label("Asset Changes", systemImage: "photo")
          .font(.title3)
          .padding(.bottom, 5)
      }
      .padding(.bottom, 10)
      
      GroupBox() {
        VStack {
          HStack{
            Label("Inserted:", systemImage: "plus.circle").bold()
            Text("\(result.fileInserted)")
            Spacer()
            
            Label("Updated:", systemImage: "pencil.and.list.clipboard").bold()
            Text("\(result.fileUpdated)")
            Spacer()
            
            Label("Unchanged:", systemImage: "pencil.slash").bold()
            Text("\(result.fileUnchanged)")
            Spacer()

            Label("Skipped:", systemImage: "forward.end.circle").bold()
            Text("\(result.fileSkipped)")
            Spacer()
          }
          .padding(.bottom, 10)

          HStack{
            Label("Marked to Delete:", systemImage: "exclamationmark.triangle").bold()
            Text("\(result.fileMarkedForDeletion)")
            Spacer()
            
            Label("Deleted:", systemImage: "trash").bold()
            Text("\(result.fileDeleted)")
            Spacer()
          }
        }
      } label: {
        Label("File Changes", systemImage: "document")
          .font(.title3)
          .padding(.bottom, 5)
      }
    }
  }
}

#Preview {
  AssetExporterResultView(
    result: AssetExporterResult.empty()
  )
}
