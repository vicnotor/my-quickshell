import "modules"
import qs.config
import qs.services
import Quickshell
import QtQuick

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
      implicitHeight: Appearance.barHeight

      Rectangle {
        anchors.fill: parent
        color: Colors.palette.m3surface
      }

      Item {
        anchors.fill: parent

        BarModuleGroup {
          id: leftBlocks
          anchors {
            left: parent.left
          }
          SysTray {
            bar: barRoot
          }
        }

        BarModuleGroup {
          id: middleBlocks
          anchors {
            horizontalCenter: parent.horizontalCenter
          }
          Workspaces {
            bar: barRoot
          }
        }

        BarModuleGroup {
          id: rightBlocks
          anchors {
            right: parent.right
          }
          Battery {
            bar: barRoot
          }
          Clock {
            bar: barRoot
          }
        }
      }
    }
  }
}
