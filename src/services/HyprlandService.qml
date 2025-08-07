import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent): void {
      const n = event.name;
      if (n.endsWith("v2"))
        return;

      if (["workspace", "moveworkspace", "activespecial", "focusedmon"].includes(n)) {
        Hyprland.refreshWorkspaces();
        Hyprland.refreshMonitors();
      } else if (["openwindow", "closewindow", "movewindow"].includes(n)) {
        Hyprland.refreshToplevels();
        Hyprland.refreshWorkspaces();
      } else if (n.includes("mon")) {
        Hyprland.refreshMonitors();
      } else if (n.includes("workspace")) {
        Hyprland.refreshWorkspaces();
      } else if (n.includes("window") || n.includes("group") || ["pin", "fullscreen", "changefloatingmode", "minimize"].includes(n)) {
        Hyprland.refreshToplevels();
      }
    }
  }
}
