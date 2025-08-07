import qs.widgets
import qs.services
import qs.config
import QtQuick
import Quickshell.Hyprland

StyledRect {
  id: root

  required property list<Workspace> workspaces
  required property Item mask
  required property real maskWidth
  required property real maskHeight
  required property int groupOffset

  readonly property int currentWsIdx: Hyprland.focusedWorkspace.id - 1 - groupOffset
  property real leading: getWsX(currentWsIdx)
  property real trailing: getWsX(currentWsIdx)
  property real currentSize: workspaces[currentWsIdx]?.size ?? 0
  property real offset: Math.min(leading, trailing)
  property real size: {
    const s = Math.abs(leading - trailing) + currentSize;
    if (lastWs > currentWsIdx)
      return Math.min(getWsX(lastWs) + (workspaces[lastWs]?.size ?? 0) - offset, s);
    return s;
  }

  property int cWs
  property int lastWs

  function getWsX(idx: int): real {
    let x = 0;
    for (let i = 0; i < idx; i++)
      x += workspaces[i]?.size ?? 0;
    return x;
  }

  onCurrentWsIdxChanged: {
    lastWs = cWs;
    cWs = currentWsIdx;
  }

  clip: true
  x: offset + 1
  y: 1
  implicitWidth: size - 2
  implicitHeight: Config.barModulesInnerHeight - 2
  radius: Appearance.rounding.full
  color: Colors.palette.m3primary

  Colorizer {
    source: root.mask
    colorizationColor: Colors.palette.m3onPrimary

    x: -parent.offset
    y: 0
    implicitWidth: root.maskWidth
    implicitHeight: root.maskHeight

    anchors.verticalCenter: parent.verticalCenter
  }

  Behavior on leading {
    enabled: true

    Anim {
      duration: Appearance.anim.durations.normal
    }
  }

  Behavior on trailing {
    enabled: true

    Anim {
      duration: Appearance.anim.durations.normal * 2
    }
  }

  Behavior on currentSize {
    enabled: true

    Anim {}
  }

  Behavior on offset {
    enabled: false

    Anim {}
  }

  Behavior on size {
    enabled: false

    Anim {}
  }

  component Anim: NumberAnimation {
    duration: Appearance.anim.durations.normal
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Appearance.anim.curves.emphasizedDecel
  }
}
