import QtQuick
import QtQuick.Layouts

BarBlock {
  implicitWidth: workspaces.implicitWidth + margin * 2
  RowLayout {
    id: workspaces
    spacing: 4
    anchors.fill: parent
    anchors.margins: parent.margin
    Workspaces {}
  }
}
