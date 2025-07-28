// Bar.qml
import "../clock"
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
        top: 4
        right: 4
        left: 4
        bottom: 4
      }

      Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#282652"
      }
      Workspaces {
        anchors.centerIn: parent
      }
      Clock {
        anchors {
          right: parent.right
          verticalCenter: parent.verticalCenter
          rightMargin: 8
        }
      }
      SysTray {
        bar: barRoot
      }
    }
  }
}
