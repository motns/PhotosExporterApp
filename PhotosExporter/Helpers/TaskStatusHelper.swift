//
//  RunStatusHelper.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 19/06/2025.
//

import Foundation
import PhotosExporterLib
import SwiftUI

enum TaskStatusHelper {
  static func imageForStatus<T>(status: TaskStatus<T>) -> some View {
    switch status {
    case .notStarted: Image(systemName: "stop.circle")
    case .skipped, .cancelled: Image(systemName: "forward.end.circle")
    case .running: Image(systemName: "arrow.trianglehead.2.clockwise")
    case .complete: Image(systemName: "checkmark.circle")
    case .failed: Image(systemName: "multiply.circle")
    }
  }
  
  static func colorForStatus<T>(status: TaskStatus<T>) -> Color {
    switch status {
    case .notStarted: .primary
    case .skipped, .cancelled: .gray
    case .running: .blue
    case .complete: .green
    case .failed: .red
    }
  }
  
  static func statusStr<T>(status: TaskStatus<T>) -> String {
    switch status {
    case .notStarted: "Not started"
    case .skipped: "Skipped"
    case .cancelled: "Cancelled"
    case .running: "Running..."
    case .complete(let result): "Completed in \(result.runTime)s"
    case .failed: "Failed"
    }
  }
}
