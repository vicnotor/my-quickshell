pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int temp: 6500

  Process {
    command: ["sh", "-c", "wl-gammarelay-rs watch {t}"]
    running: true
  }

  function setTemp(value: int) {
    value = Math.max(1000, Math.min(value, 6500));
    root.temp = value;
    Quickshell.execDetached(["sh", "-c", `busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q ${value}`]);
  }
  function tempReset(): void {
    setTemp(6500);
  }
  function tempDown(): void {
    setTemp(root.temp - 100);
  }
  function tempUp(): void {
    setTemp(root.temp + 100);
  }
}
