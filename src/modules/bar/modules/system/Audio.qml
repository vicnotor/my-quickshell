pragma ComponentBehavior: Bound

import qs.config
import qs.modules.bar
import qs.services
import qs.widgets
import QtQuick
import Quickshell

CustomMouseArea {
  id: root

  property bool showPopup: false

  Timer {
    id: timer
    interval: 200
    onTriggered: root.showPopup = false
  }

  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  onClicked: event => {
    switch (event.button) {
    case Qt.LeftButton:
      Quickshell.execDetached(["sh", "-c", "app2unit -- pavucontrol"]);
      break;
    case Qt.RightButton:
      Audio.osdActive = false;
      Audio.toggleMute();
      break;
    case Qt.MiddleButton:
      Audio.osdActive = false;
      Audio.setVolume(0.25);
      Audio.osdActive = false;
      break;
    }
    event.accepted = true;
  }

  onWheel: event => {
    Audio.osdActive = false;
    if (event.angleDelta.y > 0) {
      Audio.setVolume(Audio.volume + 0.02);
      Audio.osdActive = false;
    } else if (event.angleDelta.y < 0) {
      Audio.setVolume(Audio.volume - 0.02);
      Audio.osdActive = false;
    }
  }

  onEntered: {
    timer.stop();
    root.showPopup = true;
  }
  onExited: timer.start()

  StyledText {
    id: label
    animate: true
    text: {
      if (Audio.muted)
        return "no_sound";
      if (Audio.volume >= 0.5)
        return "volume_up";
      if (Audio.volume > 0)
        return "volume_down";
      return "volume_mute";
    }

    font.family: Appearance.font.family.material
    color: Colors.palette.m3onSurface
  }

  BarPopup {
    showPopup: root.showPopup
    anchorItem: root
    anchorY: root.height + root.height / 2 - 4
    bg: "transparent"
    content: CustomMouseArea {
      implicitWidth: column.implicitWidth
      implicitHeight: column.implicitHeight
      hoverEnabled: true

      onEntered: timer.stop()
      onExited: timer.restart()

      Row {
        id: column
        spacing: Appearance.spacing.normal

        CustomMouseArea {
          id: mouseArea1
          implicitWidth: Config.sliderWidth
          implicitHeight: Config.sliderHeight

          acceptedButtons: Qt.RightButton | Qt.MiddleButton
          hoverEnabled: true

          onClicked: event => {
            switch (event.button) {
            case Qt.RightButton:
              Audio.osdActive = false;
              Audio.toggleMute();
              break;
            case Qt.MiddleButton:
              Audio.osdActive = false;
              Audio.setVolume(0.25);
              Audio.osdActive = false;
              break;
            }
            event.accepted = true;
          }

          onWheel: event => {
            Audio.osdActive = false;
            if (event.angleDelta.y > 0) {
              Audio.setVolume(Audio.volume + 0.02);
              Audio.osdActive = false;
            } else if (event.angleDelta.y < 0) {
              Audio.setVolume(Audio.volume - 0.02);
              Audio.osdActive = false;
            }
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
            onMoved: {
              Audio.osdActive = false;
              Audio.setVolume(value);
              Audio.osdActive = false;
            }
          }
        }
        CustomMouseArea {
          id: mouseArea2
          implicitWidth: Config.sliderWidth
          implicitHeight: Config.sliderHeight

          acceptedButtons: Qt.RightButton | Qt.MiddleButton
          hoverEnabled: true

          onClicked: event => {
            switch (event.button) {
            case Qt.RightButton:
              Audio.osdActive = false;
              Audio.toggleMicMute();
              break;
            case Qt.MiddleButton:
              Audio.osdActive = false;
              Audio.setMicVolume(0.25);
              break;
            }
            event.accepted = true;
          }

          onWheel: event => {
            Audio.osdActive = false;
            if (event.angleDelta.y > 0) {
              Audio.setMicVolume(Audio.micVolume + 0.02);
              Audio.osdActive = false;
            } else if (event.angleDelta.y < 0) {
              Audio.setMicVolume(Audio.micVolume - 0.02);
              Audio.osdActive = false;
            }
          }

          VerticalSlider {
            anchors.fill: parent

            icon: {
              if (Audio.micMuted)
                return "mic_off";
              return "mic";
            }

            value: Audio.micVolume
            onMoved: {
              Audio.osdActive = false;
              Audio.setMicVolume(value);
              Audio.osdActive = false;
            }
          }
        }
      }
    }
  }
}
