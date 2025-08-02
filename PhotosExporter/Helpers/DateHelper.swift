//
//  DateHelper.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 22/06/2025.
//

import Foundation

enum DateHelper {
  static func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return formatter.string(from: date)
  }
}
