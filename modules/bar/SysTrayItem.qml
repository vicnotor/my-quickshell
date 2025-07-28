import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

MouseArea {
  id: root

  required property var bar
  required property SystemTrayItem item

  acceptedButtons: Qt.LeftButton | Qt.RightButton
  Layout.fillHeight: true
  Layout.preferredWidth: 30
  onClicked: event => {
    switch (event.button) {
    case Qt.LeftButton:
      item.activate();
      break;
    case Qt.RightButton:
      if (item.hasMenu)
        menu.open();
      break;
    }
    event.accepted = true;
  }
  QsMenuAnchor {
    id: menu
    menu: root.item.menu
    anchor {
      window: root.bar
      rect {
        x: root.x
        y: root.y
        height: root.height
      }
      edges: Edges.Bottom
    }
  }
  IconImage {
    id: trayIcon
    source: root.item.icon
    anchors.centerIn: parent
    implicitWidth: 24
    implicitHeight: 24
  }
}
