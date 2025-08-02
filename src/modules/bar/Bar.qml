import "modules"
import qs.config
import qs.services
import QtQuick

Item {
  id: root
  required property var window
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
        window: root.window
      }
    }

    BarModuleGroup {
      id: middleBlocks
      anchors {
        horizontalCenter: parent.horizontalCenter
      }
      Workspaces {}
    }

    BarModuleGroup {
      id: rightBlocks
      anchors {
        right: parent.right
      }
      Battery {}
      Clock {}
    }
  }
}
