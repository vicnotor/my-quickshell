import qs.config
import QtQuick

Rectangle {
  required property var bar
  property var margin: 4
  color: "#282652"
  radius: 13
  height: bar.height
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.anim.durations.small
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Appearance.anim.curves.standard
    }
  }
}
