pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
  id: root

  readonly property list<Monitor> monitors: variants.instances

  function getMonitorForScreen(screen: ShellScreen): var {
    return monitors.find(m => m.modelData === screen);
  }

  function changeBrightness(amount: real): void {
    const focusedName = Hyprland.focusedMonitor.name;
    const monitor = monitors.find(m => focusedName === m.modelData.name);
    if (monitor)
      monitor.setBrightness(monitor.brightness + amount);
  }

  reloadableId: "brightness"

  Variants {
    id: variants

    model: Quickshell.screens

    Monitor {}
  }

  component Monitor: QtObject {
    id: monitor

    required property ShellScreen modelData
    property real brightness

    property bool osdActive: true

    readonly property Process initProc: Process {
      stdout: StdioCollector {
        onStreamFinished: {
          const [, , , cur, max] = text.split(" ");
          monitor.brightness = parseInt(cur) / parseInt(max);
        }
      }
    }

    function setBrightness(value: real): void {
      value = Math.max(0, Math.min(1, value));
      const rounded = Math.round(value * 100);
      if (Math.round(brightness * 100) === rounded)
        return;
      brightness = value;
      Quickshell.execDetached(["brightnessctl", "s", `${rounded}%`]);
    }

    function initBrightness(): void {
      initProc.command = ["sh", "-c", "echo a b c $(brightnessctl g) $(brightnessctl m)"];

      initProc.running = true;
    }

    Component.onCompleted: initBrightness()
  }
}
