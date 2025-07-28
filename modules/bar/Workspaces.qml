import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: rowLayout
  spacing: 10

  Repeater {
    model: Hyprland.workspaces
    Rectangle {
      Layout.minimumHeight: 24
      Layout.minimumWidth: 28
      color: modelData.active ? "#4444aa" : "transparent"
      radius: 15
      border.width: 1
      border.color: "white"

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
}
