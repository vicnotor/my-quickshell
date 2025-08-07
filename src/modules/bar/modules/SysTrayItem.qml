import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

MouseArea {
  id: root

  required property var window
  required property SystemTrayItem item

  Layout.minimumHeight: Config.barModulesInnerHeight
  Layout.minimumWidth: Config.barModulesInnerHeight

  acceptedButtons: Qt.LeftButton | Qt.RightButton
  cursorShape: Qt.PointingHandCursor

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
      window: root.window
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
    implicitWidth: Config.barModulesInnerHeight
    implicitHeight: Config.barModulesInnerHeight
  }
}
