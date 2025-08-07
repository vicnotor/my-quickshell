pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property string batterySymbol
  property string batteryPercent
  property bool hasBattery: false

  Process {
    id: batteryCheck
    command: ["sh", "-c", "test -d /sys/class/power_supply/BAT*"]
    running: true
    onExited: function (exitCode, _) {
      root.hasBattery = exitCode === 0;
    }
  }

  Process {
    id: batteryProc
    // Modify command to get both capacity and status in one call
    command: ["sh", "-c", "echo $(cat /sys/class/power_supply/BAT*/capacity),$(cat /sys/class/power_supply/BAT*/status)"]
    running: root.hasBattery

    stdout: SplitParser {
      onRead: function (data) {
        const [capacityStr, status] = data.trim().split(',');
        const capacity = parseInt(capacityStr);
        let batteryIcon = "󰂂";
        if (capacity <= 20)
          batteryIcon = "󰁺";
        else if (capacity <= 40)
          batteryIcon = "󰁽";
        else if (capacity <= 60)
          batteryIcon = "󰁿";
        else if (capacity <= 80)
          batteryIcon = "󰂁";
        else
          batteryIcon = "󰂂";

        const symbol = status === "Charging" ? "󰂄" : status === "Not charging" ? "󱈑" : batteryIcon;
        root.batteryPercent = `${capacity}%`;
        root.batterySymbol = `${symbol}`;
      }
    }
  }

  Timer {
    interval: 1000
    running: root.hasBattery
    repeat: true
    onTriggered: batteryProc.running = true
  }
}
