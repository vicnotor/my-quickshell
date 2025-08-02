pragma ComponentBehavior: Bound

import qs.config
import qs.modules.bar
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

BarModule {
  id: root
  required property var window
  content: RowLayout {
    spacing: Appearance.spacing.small
    Repeater {
      model: SystemTray.items
      SysTrayItem {
        required property SystemTrayItem modelData
        item: modelData
        window: root.window
      }
    }
  }
}
