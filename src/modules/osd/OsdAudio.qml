pragma ComponentBehavior:Bound

import qs.config
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
    function onMicVolumeChanged() {
      root.show();
    }
    function onMicMutedChanged() {
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
      margins.right: mouseArea1.implicitWidth / 2
      exclusiveZone: 0

      WlrLayershell.layer: WlrLayer.Overlay

      implicitWidth: column.implicitWidth
      implicitHeight: column.implicitHeight

      color: "transparent"

      Rectangle {
        anchors.fill: parent
        color: Colors.palette.m3surface
        radius: Appearance.rounding.normal
      }

      Column {
        id: column
        padding: Appearance.padding.large
        spacing: Appearance.spacing.normal

        CustomMouseArea {
          id: mouseArea1
          implicitWidth: Config.sliderWidth
          implicitHeight: Config.sliderHeight

          hoverEnabled: true

          onEntered: timer.stop()
          onExited: timer.restart()

          onWheel: event => {
            if (event.angleDelta.y > 0)
              Audio.setVolume(Audio.volume + 0.02);
            else if (event.angleDelta.y < 0)
              Audio.setVolume(Audio.volume - 0.02);
          }

          VerticalSlider {
            anchors.fill: parent

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
        CustomMouseArea {
          id: mouseArea2
          implicitWidth: Config.sliderWidth
          implicitHeight: Config.sliderHeight

          onWheel: event => {
            if (event.angleDelta.y > 0)
              Audio.setMicVolume(Audio.micVolume + 0.02);
            else if (event.angleDelta.y < 0)
              Audio.setMicVolume(Audio.micVolume - 0.02);
          }

          VerticalSlider {
            anchors.fill: parent

            icon: {
              if (Audio.micMuted)
                return "mic_off";
              return "mic";
            }

            value: Audio.micVolume
            onMoved: Audio.setMicVolume(value)
          }
        }
      }
    }
  }
}
