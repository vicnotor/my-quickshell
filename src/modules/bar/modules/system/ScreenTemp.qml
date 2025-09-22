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

  function show(): void {
    root.showPopup = true;
    timer.restart();
  }

  Connections {
    target: ScreenTemp

    function onTempChanged() {
      root.show();
    }
  }

  Timer {
    id: timer
    interval: Config.sliderTimeout
    onTriggered: root.showPopup = false
  }

  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  acceptedButtons: Qt.RightButton | Qt.MiddleButton
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  onWheel: event => {
    if (event.angleDelta.y > 0)
      ScreenTemp.tempUp(100);
    else if (event.angleDelta.y < 0)
      ScreenTemp.tempDown(100);
  }

  onClicked: event => {
    switch (event.button) {
    case Qt.RightButton:
      ScreenTemp.tempReset();
      break;
    case Qt.MiddleButton:
      ScreenTemp.setTemp(3800);
      break;
    }
    event.accepted = true;
  }

  onEntered: root.showPopup = true
  onExited: root.showPopup = false

  StyledText {
    id: label
    animate: true
    text: {
      let temp = ScreenTemp.temp;
      if (temp === 6500)
        return "light_mode";
      else
        return "mode_night";
    }
    font.family: Appearance.font.family.material
    color: {
      let temp = ScreenTemp.temp;
      if (temp === 6500)
        return Colors.palette.m3onSurface;
      else if (temp >= 2000)
        return Colors.palette.darkred;
      else
        return Colors.palette.m3errorContainer;
    }
  }

  BarPopup {
    showPopup: root.showPopup
    anchorItem: root
    anchorY: root.height + root.height / 2 - 4
    content: Text {
      text: `${ScreenTemp.temp}K`
      font.family: Appearance.font.family.sans
      color: Colors.palette.m3onSurface
    }
  }
}
