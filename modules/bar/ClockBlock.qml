import qs.modules.clock
import QtQuick
import QtQuick.Layouts

BarBlock {
  id: root
  implicitWidth: clockLabel.implicitWidth + margin * 4
  RowLayout {
    id: item
    anchors.fill: parent
    anchors.margins: parent.margin
    spacing: 0

    Clock {
      id: clockLabel
      Layout.alignment: Qt.AlignCenter
      verticalAlignment: Text.AlignVCenter
    }
  }
}
