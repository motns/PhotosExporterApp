//
//  CollectionExporterResult.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 22/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct CollectionExporterResultView: View {
  let result: CollectionExporterResult

  var body: some View {
    VStack {
      GroupBox() {
        VStack {
          HStack{
            Label("Inserted:", systemImage: "plus.circle").bold()
            Text("\(result.folderInserted)")
            Spacer()
            
            Label("Updated:", systemImage: "pencil.and.list.clipboard").bold()
            Text("\(result.folderUpdated)")
            Spacer()
            
            Label("Unchanged:", systemImage: "pencil.slash").bold()
            Text("\(result.folderUnchanged)")
            Spacer()
            
            Label("Deleted:", systemImage: "trash").bold()
            Text("\(result.folderDeleted)")
            Spacer()
          }
        }
      } label: {
        Label("Folder Changes", systemImage: "folder")
          .font(.title3)
          .padding(.bottom, 5)
      }
      .padding(.bottom, 10)
      
      GroupBox() {
        VStack {
          HStack{
            Label("Inserted:", systemImage: "plus.circle").bold()
            Text("\(result.albumInserted)")
            Spacer()
            
            Label("Updated:", systemImage: "pencil.and.list.clipboard").bold()
            Text("\(result.albumUpdated)")
            Spacer()
            
            Label("Unchanged:", systemImage: "pencil.slash").bold()
            Text("\(result.albumUnchanged)")
            Spacer()
            
            Label("Deleted:", systemImage: "trash").bold()
            Text("\(result.albumDeleted)")
            Spacer()
          }
        }
      } label: {
        Label("Album Changes", systemImage: "photo.stack")
          .font(.title3)
          .padding(.bottom, 5)
      }
    }
  }
}

#Preview {
  CollectionExporterResultView(
    result: CollectionExporterResult.empty()
  )
}
