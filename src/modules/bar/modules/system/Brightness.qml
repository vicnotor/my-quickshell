pragma ComponentBehavior: Bound

import qs.config
import qs.modules.bar
import qs.services
import qs.widgets
import QtQuick

CustomMouseArea {
  id: root

  property Brightness.Monitor monitor: Brightness.monitors[0]
  property bool showPopup: false

  Timer {
    id: timer
    interval: 200
    onTriggered: root.showPopup = false
  }

  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  acceptedButtons: Qt.LeftButton | Qt.RightButton
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  onClicked: event => {
    switch (event.button) {
    case Qt.RightButton:
      root.monitor.osdActive = false;
      root.monitor?.setBrightness(0.5);
      break;
    }
    event.accepted = true;
  }

  onWheel: event => {
    let current = root.monitor?.brightness ?? 0;
    if (event.angleDelta.y > 0) {
      root.monitor.osdActive = false;
      root.monitor?.setBrightness(current + 0.05);
    } else if (event.angleDelta.y < 0) {
      root.monitor.osdActive = false;
      root.monitor?.setBrightness(current - 0.05);
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
    text: `brightness_${(Math.round((root.monitor?.brightness ?? 0) * 6) + 1)}`
    font.family: Appearance.font.family.material
    color: Colors.palette.m3onSurface
  }

  BarPopup {
    showPopup: root.showPopup
    anchorItem: root
    anchorY: root.height + root.height / 2 - 4
    bg: "transparent"
    content: CustomMouseArea {
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
          root.monitor.osdActive = false;
          root.monitor?.setBrightness(0.5);
          break;
        }
        event.accepted = true;
      }

      onWheel: event => {
        let current = root.monitor?.brightness ?? 0;
        if (event.angleDelta.y > 0) {
          root.monitor.osdActive = false;
          root.monitor?.setBrightness(current + 0.05);
        } else if (event.angleDelta.y < 0) {
          root.monitor.osdActive = false;
          root.monitor?.setBrightness(current - 0.05);
        }
      }

      VerticalSlider {
        anchors.fill: parent

        icon: `brightness_${(Math.round(value * 6) + 1)}`
        value: root.monitor?.brightness ?? 0
        onMoved: {
          root.monitor.osdActive = false;
          root.monitor?.setBrightness(value);
        }
      }
    }
  }
}
