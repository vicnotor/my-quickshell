import "modules"
import qs.config
import qs.services
import qs.widgets
import QtQuick

Item {
  id: root
  required property var window
  implicitHeight: Config.barHeight

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
      HorizontalSpacer {
        size: 2
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
      HorizontalSpacer {
        size: 2
      }
    }
  }
}
