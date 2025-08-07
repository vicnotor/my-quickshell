import qs.widgets
import qs.services
import qs.config
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
  id: root

  required property int index
  required property var occupied
  required property int groupOffset

  readonly property bool isWorkspace: true
  readonly property real size: childrenRect.height + (hasWindows ? Appearance.padding.smaller : 0)

  readonly property int ws: groupOffset + index + 1
  readonly property bool isOccupied: occupied[ws] ?? false
  readonly property bool hasWindows: false

  Layout.preferredWidth: size
  Layout.preferredHeight: childrenRect.height

  StyledText {
    id: indicator

    readonly property string label: root.ws

    animate: true
    text: label
    color: root.isOccupied || Hyprland.focusedWorkspace.id === root.ws ? Colors.palette.m3onSurface : Colors.palette.m3outlineVariant
    horizontalAlignment: StyledText.AlignHCenter
    verticalAlignment: StyledText.AlignVCenter

    width: Config.barModulesInnerHeight - 1
    height: Config.barModulesInnerHeight
  }

  Behavior on Layout.preferredWidth {
    Anim {}
  }

  Behavior on Layout.preferredHeight {
    Anim {}
  }

  component Anim: NumberAnimation {
    duration: Appearance.anim.durations.normal
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Appearance.anim.curves.standard
  }
}
