pragma ComponentBehavior: Bound

import qs.config
import qs.modules.bar
import qs.services
import qs.widgets
import QtQuick
import Quickshell
import Quickshell.Io

MouseArea {
  id: root

  property bool showPopup: false

  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  acceptedButtons: Qt.LeftButton
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  onClicked: event => {
    switch (event.button) {
    case Qt.LeftButton:
      Quickshell.execDetached(["sh", "-c", "app2unit -- taskmanager"]);
      break;
    }
    event.accepted = true;
  }

  onEntered: root.showPopup = true
  onExited: root.showPopup = false

  StyledText {
    id: label
    animate: true
    text: BatteryStatus.batterySymbol
    font.family: Appearance.font.family.sans
    color: Colors.palette.m3onSurface
  }

  BarPopup {
    showPopup: root.showPopup
    anchorItem: root
    anchorY: root.height + root.height / 2 - 4
    content: Text {
      text: BatteryStatus.batteryPercent
      font.family: Appearance.font.family.sans
      color: Colors.palette.m3onSurface
    }
  }
}
