pragma ComponentBehavior: Bound

import qs.modules.bar
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

BarModule {
  id: root
  content: RowLayout {
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
