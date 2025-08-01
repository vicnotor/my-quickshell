import qs.config
import qs.modules.bar
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
        bottom: true
      }
      implicitWidth: 100
      margins {
        top: Appearance.margins.small
        left: 0
        right: Appearance.margins.small
        bottom: Appearance.margins.small
      }

      Item {
        anchors.fill: parent
        BrightnessSlider {
          monitor: Brightness.monitors[0]
        }
      }
    }
  }
}
