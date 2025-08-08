import "osd"
import qs.config
import qs.modules.bar
import qs.services
import qs.widgets
import Quickshell
import QtQuick

Variants {
  model: Quickshell.screens

  Scope {
    id: scope

    required property ShellScreen modelData

    PanelWindow {
      id: win
      screen: scope.modelData

      color: "transparent"
      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: Config.barHeight
      exclusiveZone: Config.barHeight

      // All components
      Bar {
        id: bar
        anchors.fill: parent
        window: win
      }
      OsdAudio {}
      OsdBrightness {}
      Shortcuts {}
      Item {
        visible: HyprlandService.dummyProp
      }

      // Toggle visibility of bar
      visible: true
      function toggleBar() {
        bar.visible = !bar.visible;
        if (win.exclusiveZone === 0)
          win.exclusiveZone = Config.barHeight;
        else
          win.exclusiveZone = 0;
      }
      CustomShortcut {
        name: "toggleBar"
        description: "Toggle Bar visibility"
        onPressed: win.toggleBar()
      }
    }
  }
}
