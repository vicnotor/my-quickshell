pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Item {
  id: root

  required property var bar

  height: parent.height
  implicitWidth: rowLayout.implicitWidth

  RowLayout {
    id: rowLayout
    anchors.fill: parent
    spacing: 0

    Repeater {
      model: SystemTray.items
      SysTrayItem {
        required property SystemTrayItem modelData
        bar: root.bar
        item: modelData
      }
    }
  }
}
