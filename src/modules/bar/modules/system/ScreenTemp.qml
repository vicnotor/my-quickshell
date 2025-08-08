pragma ComponentBehavior: Bound

import qs.config
import qs.modules.bar
import qs.services
import qs.widgets
import QtQuick

CustomMouseArea {
  id: root

  property bool showPopup: false

  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  acceptedButtons: Qt.RightButton | Qt.MiddleButton
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  onWheel: event => {
    if (event.angleDelta.y > 0)
      ScreenTemp.tempUp();
    else if (event.angleDelta.y < 0)
      ScreenTemp.tempDown();
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
        return "clear_day";
      else if (temp >= 5000)
        return "brightness_3";
      else if (temp >= 2000)
        return "brightness_2";
      else
        return "brightness_1";
    }
    font.family: Appearance.font.family.material
    color: Colors.palette.m3onSurface
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
