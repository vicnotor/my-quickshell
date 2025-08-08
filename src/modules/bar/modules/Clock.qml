import qs.config
import qs.modules.bar
import qs.services
import QtQuick
import Quickshell.Io

BarModule {
  id: root
  property bool showPopup: false
  content: MouseArea {
    id: mouseArea
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    acceptedButtons: Qt.LeftButton
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    Process {
      id: process
      command: ["sh", "-c", "xdg-open https://calendar.google.com"]
    }

    onClicked: event => {
      switch (event.button) {
      case Qt.LeftButton:
        process.startDetached();
        break;
      }
      event.accepted = true;
    }

    onEntered: root.showPopup = true
    onExited: root.showPopup = false

    Text {
      id: label
      text: Time.time
      font.family: Appearance.font.family.sans
      color: Colors.palette.m3onSurface
    }
  }

  BarPopup {
    showPopup: root.showPopup
    anchorItem: root
    content: Text {
      text: Time.date
      font.family: Appearance.font.family.sans
      color: Colors.palette.m3onSurface
    }
  }
}
