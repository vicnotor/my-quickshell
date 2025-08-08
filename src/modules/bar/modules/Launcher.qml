import qs.config
import qs.modules.bar
import qs.services
import qs.utils
import QtQuick
import Quickshell.Io

BarModule {
  id: root
  content: MouseArea {

    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight

    acceptedButtons: Qt.LeftButton
    cursorShape: Qt.PointingHandCursor

    Process {
      id: process

      command: ["sh", "-c", "rofi -show drun -show-icons -run-command 'app2unit -- {cmd}'"]
      running: false
    }

    onClicked: event => {
      switch (event.button) {
      case Qt.LeftButton:
        process.running = true;
        break;
      }
      event.accepted = true;
    }

    Text {
      id: icon
      text: Icons.osIcon
      font.pointSize: Appearance.font.size.normal
      font.family: Appearance.font.family.mono
      color: Colors.palette.m3primary
    }
  }
}
