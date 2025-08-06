import qs.widgets
import qs.services
import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
  id: root

  property bool shouldShowOsd: false

  function show(): void {
    root.shouldShowOsd = true;
    timer.restart();
  }

  Connections {
    target: Audio

    function onVolumeChanged() {
      root.show();
    }
    function onMutedChanged() {
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
      anchors.right: true
      margins.right: volumeSlider.implicitWidth
      exclusiveZone: 0

      WlrLayershell.layer: WlrLayer.Overlay

      implicitWidth: volumeSlider.implicitWidth
      implicitHeight: volumeSlider.implicitHeight
      color: "transparent"

      VerticalSlider {
        id: volumeSlider

        icon: {
          if (Audio.muted)
            return "no_sound";
          if (value >= 0.5)
            return "volume_up";
          if (value > 0)
            return "volume_down";
          return "volume_mute";
        }

        value: Audio.volume
        onMoved: Audio.setVolume(value)
      }
    }
  }
}
