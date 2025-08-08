import qs.config
import qs.widgets
import QtQuick

StyledRect {
  id: root

  property Item content
  property var margin: Appearance.margins.smaller
  property color bg: "transparent"

  color: bg
  radius: Appearance.rounding.small
  implicitHeight: Config.barModulesHeight
  implicitWidth: contentContainer.implicitWidth + margin * 2

  Item {
    // Contents of the bar block
    id: contentContainer
    implicitWidth: root.content.implicitWidth
    implicitHeight: root.content.implicitHeight
    anchors.centerIn: root
    children: [root.content]
  }

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.anim.durations.small
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Appearance.anim.curves.standard
    }
  }
}
