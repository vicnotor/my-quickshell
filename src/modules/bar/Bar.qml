import "modules" as BarModules
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
      BarModules.Launcher {}
      BarModules.SysTray {
        window: root.window
      }
    }

    BarModuleGroup {
      id: middleBlocks
      anchors {
        horizontalCenter: parent.horizontalCenter
      }
      BarModules.Workspaces {}
    }

    BarModuleGroup {
      id: rightBlocks
      anchors {
        right: parent.right
      }
      BarModules.System {}
      BarModules.Clock {}
      HorizontalSpacer {
        size: 2
      }
    }
  }
}
