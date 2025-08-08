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

      // All components
      Bar {
        anchors.fill: parent
        window: win
      }
      OsdAudio {}
      OsdBrightness {}
      Shortcuts {}
      Item {
        visible: HyprlandService.dummyProp
      }

      // Toggle visibility of shell
      visible: true
      function toggleShell() {
        visible = !visible;
      }
      CustomShortcut {
        name: "toggleShell"
        description: "Toggle Shell visibility"
        onPressed: win.toggleShell()
      }
    }
  }
}
