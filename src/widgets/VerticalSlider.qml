import qs.services
import qs.widgets
import qs.config
import QtQuick
import QtQuick.Controls

Slider {
  id: root

  required property string icon
  property real oldValue

  Component.onCompleted: {
    oldValue = value;
    handle.moving = false;

    if (typeof icon !== "undefined") {
      toNumberAnim.stop();
      toIconAnim.stop();
      icon.applyIconVisual();
    }
  }

  orientation: Qt.Vertical

  background: StyledRect {
    color: Colors.palette.m3surfaceContainer
    radius: Appearance.rounding.full

    StyledRect {
      anchors.left: parent.left
      anchors.right: parent.right

      y: root.handle.y
      implicitHeight: parent.height - y

      color: Colors.palette.m3secondary
      radius: parent.radius
    }
  }

  handle: Item {
    id: handle

    property bool moving

    y: root.visualPosition * (root.availableHeight - height)
    implicitWidth: root.width
    implicitHeight: root.width

    Elevation {
      anchors.fill: parent
      radius: rect.radius
      level: handleInteraction.containsMouse ? 2 : 1
    }

    StyledRect {
      id: rect

      anchors.fill: parent

      color: Colors.palette.m3inverseSurface
      radius: Appearance.rounding.full

      MouseArea {
        id: handleInteraction

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.NoButton
      }

      MaterialIcon {
        id: icon

        property bool moving: handle.moving
        property real visualScale: 1
        scale: visualScale

        function applyNumberVisual() {
          animate = false;

          var immediate = Math.round(root.value * 100);
          text = (isFinite(immediate) ? immediate.toString() : "0");

          text = Qt.binding(() => {
            var v = Math.round(root.value * 100);
            return (typeof v === "number" && !isNaN(v)) ? v.toString() : "0";
          });

          font.pointSize = Appearance.font.size.small;
          font.family = Appearance.font.family.sans;
        }

        function applyIconVisual() {
          animate = true;
          text = Qt.binding(() => root.icon);
          font.pointSize = Appearance.font.size.larger;
          font.family = Appearance.font.family.material;
        }

        anchors.centerIn: parent
        color: Colors.palette.m3inverseOnSurface

        SequentialAnimation {
          id: toNumberAnim
          NumberAnimation {
            target: icon
            property: "visualScale"
            from: icon.visualScale
            to: 0
            duration: Appearance.anim.durations.normal / 2
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.standardAccel
          }
          ScriptAction {
            script: icon.applyNumberVisual()
          }
          NumberAnimation {
            target: icon
            property: "visualScale"
            from: 0
            to: 1
            duration: Appearance.anim.durations.normal / 2
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.standardDecel
          }
        }

        SequentialAnimation {
          id: toIconAnim
          NumberAnimation {
            target: icon
            property: "visualScale"
            from: icon.visualScale
            to: 0
            duration: Appearance.anim.durations.normal / 2
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.standardAccel
          }
          ScriptAction {
            script: icon.applyIconVisual()
          }
          NumberAnimation {
            target: icon
            property: "visualScale"
            from: 0
            to: 1
            duration: Appearance.anim.durations.normal / 2
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.standardDecel
          }
        }

        onMovingChanged: {
          toNumberAnim.stop();
          toIconAnim.stop();
          if (moving)
            toNumberAnim.start();
          else
            toIconAnim.start();
        }
      }
    }
  }

  onPressedChanged: handle.moving = pressed

  onValueChanged: {
    if (Math.abs(value - oldValue) < 0.01)
      return;
    oldValue = value;
    handle.moving = true;
    stateChangeDelay.restart();
  }

  Timer {
    id: stateChangeDelay

    interval: 800
    onTriggered: {
      if (!root.pressed)
        handle.moving = false;
    }
  }

  Behavior on value {
    NumberAnimation {
      duration: Appearance.anim.durations.large
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Appearance.anim.curves.standardDecel
    }
  }
}
