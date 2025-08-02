//
//  RunStateIcon.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 19/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct TaskStatusIcon<SuccessResponse>: View where SuccessResponse: Sendable, SuccessResponse: Timeable {
  var status: TaskStatus<SuccessResponse>
  var font: Font?

  var body: some View {
    if case .running = status {
      TaskStatusHelper.imageForStatus(status: status)
        .symbolRenderingMode(.palette)
        .foregroundStyle(
          TaskStatusHelper.colorForStatus(status: status)
        )
        .font(font ?? .title3)
        .symbolEffect(.rotate.byLayer, options: .repeat(.continuous).speed(1.2))
    } else {
      TaskStatusHelper.imageForStatus(status: status)
        .symbolRenderingMode(.palette)
        .foregroundStyle(
          TaskStatusHelper.colorForStatus(status: status)
        )
        .font(font ?? .title3)
    }
  }
}

#Preview {
  Group {
    TaskStatusIcon(status: TaskStatus<EmptyTaskSuccess>.notStarted)
    TaskStatusIcon(status: TaskStatus<EmptyTaskSuccess>.running(
      TaskProgress(toProcess: 100, processed: 26)
    ))
    TaskStatusIcon(status: TaskStatus<EmptyTaskSuccess>.failed("It is all on fire!"))
    TaskStatusIcon(status: TaskStatus<EmptyTaskSuccess>.complete(
      EmptyTaskSuccess(runTime: 46.28)
    ))
  }
}
