//
//  DirectorySelection.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 13/06/2025.
//

import SwiftUI

struct DirectorySelection: View {
  @Environment(AppModel.self) var appModel
  
  @State private var errorMsg: String? = nil
  @State private var showFilePicker: Bool = false

  var body: some View {
    HStack(alignment: .top) {
      Image("exporter_logo_128")
        .resizable()
        .frame(width: 120, height: 120)
        
      VStack(alignment: .leading) {
        GroupBox {
          Text("""
          Welcome to Photos Exporter!

          Please select a new (empty) folder where you would like to have your Apple Photos library exported to.
          
          If you've already done an export in the past and would like to refresh it, please select the folder where you previously exported to.
          """)
          .padding()
          .frame(minWidth: 160, minHeight: 165)
        }
        
        HStack {
          Spacer()
          Button {
            showFilePicker = true
          } label: {
            Label("Select Folder", systemImage: "folder")
          }
          .buttonStyle(.borderedProminent)
          .controlSize(.large)
          .fileImporter(
            isPresented: $showFilePicker,
            allowedContentTypes: [.directory]
          ) { result in
            switch result {
            case .success(let url):
              appModel.setExportURL(url)
            case .failure(let error):
              appModel.setError(title: "", message: "\(error)")
              errorMsg = "\(error)"
            }
          }
          .fileDialogDefaultDirectory(appModel.lastExportURL)
        }
        .padding(.top, 10)
      }
      .padding(.leading, 10)
    }
    .padding()
    .frame(minWidth: 500, minHeight: 275)
  }
}

#Preview {
  DirectorySelection()
    .environment(AppModel())
}
