pragma ComponentBehavior: Bound

import qs.widgets
import qs.services
import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
  id: root

  required property Brightness.Monitor monitor

  property bool shouldShowOsd: false

  function show(): void {
    root.shouldShowOsd = true;
    timer.restart();
  }

  Connections {
    target: Brightness.monitors[0]

    function onBrightnessChanged(): void {
      root.show();
    }
  }

  Timer {
    id: timer
    interval: 2000
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.left: true
      margins.left: slider.implicitWidth
      exclusiveZone: 0

      WlrLayershell.layer: WlrLayer.Overlay

      implicitWidth: slider.implicitWidth
      implicitHeight: slider.implicitHeight
      color: "transparent"

      VerticalSlider {
        id: slider
        icon: `brightness_${(Math.round(value * 6) + 1)}`
        value: root.monitor?.brightness ?? 0
        onMoved: root.monitor?.setBrightness(value)
      }
    }
  }
}
