import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Repeater {
  id: repeater
  model: Hyprland.workspaces
  Rectangle {
    Layout.minimumHeight: 24
    Layout.minimumWidth: 28
    color: modelData.active ? "#4444aa" : "transparent"
    radius: 12
    border.width: 0

    Text {
      anchors.centerIn: parent
      color: "white"
      font.bold: true
      text: modelData.id
    }

    MouseArea {
      anchors.fill: parent
      onClicked: Hyprland.dispatch("workspace " + modelData.id)
    }
  }
}
