pragma ComponentBehavior: Bound

import qs.config
import qs.modules.bar
import qs.services
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

BarModule {
  id: root
  bg: Colors.palette.m3surfaceContainer

  required property var window

  visible: width > 0 && height > 0 // To avoid warnings about being visible with no size

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
    Behavior on implicitWidth {
      NumberAnimation {
        duration: Appearance.anim.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.standard
      }
    }
  }
}
