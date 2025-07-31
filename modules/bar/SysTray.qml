pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

BarBlock {
  id: root

  implicitWidth: rowLayout.implicitWidth + margin * 2

  RowLayout {
    id: rowLayout
    anchors.fill: parent
    anchors.margins: parent.margin
    spacing: 0

    Repeater {
      model: SystemTray.items
      SysTrayItem {
        required property SystemTrayItem modelData
        bar: bar
        item: modelData
      }
    }
  }
}
