import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barRoot
      required property var modelData
      screen: modelData
      color: "transparent"
      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: 32
      margins {
        top: 0
        right: 4
        left: 4
        bottom: 4
      }

      Item {
        anchors.fill: parent

        RowLayout {
          anchors {
            top: parent.top
            left: parent.left
            horizontalCenter: parent.horizontalCenter
          }
          SysTray {
            bar: barRoot
          }
        }

        WorkspaceBar {
          bar: barRoot
          anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
          }
        }

        ClockBlock {
          bar: barRoot
          anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
          }
        }
      }
    }
  }
}
