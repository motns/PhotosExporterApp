//
//  RunStateLabel.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 19/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct TaskStatusLabel<SuccessResponse>: View where SuccessResponse: Sendable, SuccessResponse: Timeable {
  var status: TaskStatus<SuccessResponse>
  var font: Font? = .body

  var body: some View {
    HStack {
      if case .running = status {
        Text(TaskStatusHelper.statusStr(status: status))
          .font(font)
          .italic()
          .padding(.leading, 5)
          .foregroundColor(
            TaskStatusHelper.colorForStatus(status: status)
          )
          .phaseAnimator([1, 2]) { view, phase in
            view
              .opacity(phase == 1 ? 1 : 0.3)
          } animation: { phase in .linear(duration: 0.7) }
      } else {
        Text(TaskStatusHelper.statusStr(status: status))
          .font(font)
          .italic()
          .padding(.leading, 5)
          .foregroundColor(
            TaskStatusHelper.colorForStatus(status: status)
          )
        
        if case .failed(let errorMessage) = status {
          Image(systemName: "info.circle")
            .foregroundColor(
              TaskStatusHelper.colorForStatus(status: status)
            )
            .help(errorMessage)
        }
      }
    }
  }
}

#Preview {
  Group {
    TaskStatusLabel(status: TaskStatus<EmptyTaskSuccess>.notStarted)
    TaskStatusLabel(status: TaskStatus<EmptyTaskSuccess>.running(
      TaskProgress(toProcess: 100, processed: 27)
    ))
    TaskStatusLabel(status: TaskStatus<EmptyTaskSuccess>.failed("It is all on fire!"))
    TaskStatusLabel(status: TaskStatus<EmptyTaskSuccess>.complete(
      EmptyTaskSuccess(runTime: 45.26)
    ))
  }
}
