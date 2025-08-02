//
//  RunStatusRow.swift
//  PhotosExporter
//
//  Created by Adam Borocz on 20/06/2025.
//

import SwiftUI
import PhotosExporterLib

struct TaskStatusView<SuccessResponse>: View where SuccessResponse: Sendable, SuccessResponse: Timeable {
  var taskName: String
  var status: TaskStatus<SuccessResponse>

  var showSubtasks: Binding<Bool>?
  var taskNameFont: Font? = .title3
  var runStateFont: Font? = .title3

  var body: some View {
    GroupBox {
      HStack {
        TaskStatusIcon(
          status: status,
          font: taskNameFont,
        )

        Text(taskName)
          .foregroundColor(
            TaskStatusHelper.colorForStatus(status: status)
          )
          .font(taskNameFont)
        
        switch status {
        case .running(let progressOpt):
          switch progressOpt {
          case .some(let taskProgress):
            ProgressView(
              value: taskProgress.progress,
              label: {
                Text("Running...")
                  .font(runStateFont)
              },
              currentValueLabel: {
                Text("\(taskProgress.progress * 100, specifier: "%.2f")%")
                  .font(runStateFont)
              }
            )
            .foregroundColor(
              TaskStatusHelper.colorForStatus(status: status)
            )
            .padding(.leading, 15)

          case .none:
            TaskStatusLabel(
              status: status,
              font: runStateFont,
            )
          }
        default:
          TaskStatusLabel(
            status: status,
            font: runStateFont,
          )
        }

        Spacer()

        if let showSubtasks {
          Button {
            showSubtasks.wrappedValue.toggle()
          } label: {
            Label("Subtasks", systemImage: "chevron.right.circle")
              .labelStyle(.iconOnly)
              .imageScale(.large)
              .rotationEffect(.degrees(showSubtasks.wrappedValue ? 90 : 0))
              .scaleEffect(showSubtasks.wrappedValue ? 1.2 : 1)
              .animation(.easeInOut(duration: 0.2), value: showSubtasks.wrappedValue)
          }
          .buttonStyle(.borderless)
          .padding(.leading, 15)
        }
      }
      .padding(5)
      .padding(.leading, 10)
      .padding(.trailing, 10)
    }
  }
}

#Preview {
  Group {
    TaskStatusView(
      taskName: "Asset Export",
      status: TaskStatus<EmptyTaskSuccess>.notStarted,
      showSubtasks: .constant(true),
    )
    TaskStatusView(
      taskName: "Asset Export",
      status: TaskStatus<EmptyTaskSuccess>.running(
        TaskProgress(toProcess: 100, processed: 27),
      ),
      showSubtasks: .constant(true),
    )
    TaskStatusView(
      taskName: "Asset Export",
      status: TaskStatus<EmptyTaskSuccess>.skipped,
      showSubtasks: .constant(true),
    )
    TaskStatusView(
      taskName: "Asset Export",
      status: TaskStatus<EmptyTaskSuccess>.complete(
        EmptyTaskSuccess(runTime: 12.34),
      ),
      showSubtasks: .constant(false),
    )
    TaskStatusView(
      taskName: "Asset Export",
      status: TaskStatus<EmptyTaskSuccess>.failed("It all went wrong..."),
      showSubtasks: .constant(false),
    )
  }
}
