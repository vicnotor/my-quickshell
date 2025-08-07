pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
  id: root

  readonly property list<Workspace> workspaces: layout.children.filter(c => c.isWorkspace).sort((w1, w2) => w1.ws - w2.ws)
  readonly property var occupied: {
    Hyprland.workspaces.values.reduce((acc, curr) => {
      acc[curr.id] = curr.lastIpcObject.windows > 0;
      return acc;
    }, {});
  }

  readonly property int groupOffset: Math.floor((Hyprland.focusedWorkspace.id - 1) / 10) * 10 // 10 workspaces total

  implicitWidth: layout.implicitWidth
  implicitHeight: layout.implicitHeight

  RowLayout {
    id: layout

    spacing: 0
    layer.enabled: true
    layer.smooth: true

    Repeater {
      model: 10 // 10 workspaces total

      Workspace {
        occupied: root.occupied
        groupOffset: root.groupOffset
      }
    }
  }

  Loader {
    active: true
    asynchronous: true

    sourceComponent: ActiveIndicator {
      workspaces: root.workspaces
      mask: layout
      maskWidth: root.width
      maskHeight: root.height
      groupOffset: root.groupOffset
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onPressed: event => {
      const ws = layout.childAt(event.x, event.y).index + root.groupOffset + 1;
      if (Hyprland.focusedWorkspace.id !== ws)
        Hyprland.dispatch(`workspace ${ws}`);
    }
  }
}
