pragma ComponentBehavior: Bound

import qs.config
import qs.widgets
import qs.services
import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
  id: root

  property Brightness.Monitor monitor: Brightness.monitors[0]

  property bool shouldShowOsd: false

  function show(): void {
    if (monitor.osdActive) {
      root.shouldShowOsd = true;
      timer.restart();
    } else
      monitor.osdActive = true;
  }

  Connections {
    target: Brightness.monitors[0]

    function onBrightnessChanged(): void {
      root.show();
    }
  }

  Timer {
    id: timer
    interval: Config.sliderTimeout
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.left: true
      margins.left: mouseArea.implicitWidth / 2
      exclusiveZone: 0

      WlrLayershell.layer: WlrLayer.Overlay

      implicitWidth: mouseArea.implicitWidth
      implicitHeight: mouseArea.implicitHeight
      color: "transparent"

      CustomMouseArea {
        id: mouseArea
        implicitWidth: Config.sliderWidth
        implicitHeight: Config.sliderHeight

        acceptedButtons: Qt.RightButton
        hoverEnabled: true

        onEntered: timer.stop()
        onExited: timer.restart()

        onClicked: event => {
          switch (event.button) {
          case Qt.RightButton:
            root.monitor?.setBrightness(0.5);
            break;
          }
          event.accepted = true;
        }

        onWheel: event => {
          let current = root.monitor?.brightness ?? 0;
          if (event.angleDelta.y > 0)
            root.monitor?.setBrightness(current + 0.05);
          else if (event.angleDelta.y < 0)
            root.monitor?.setBrightness(current - 0.05);
        }

        VerticalSlider {
          anchors.fill: parent

          icon: `brightness_${(Math.round(value * 6) + 1)}`
          value: root.monitor?.brightness ?? 0
          onMoved: root.monitor?.setBrightness(value)
        }
      }
    }
  }
}
