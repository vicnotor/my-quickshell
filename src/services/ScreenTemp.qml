pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int temp: 999

  Process {
    id: proc
    command: ["sh", "-c", "wl-gammarelay-rs watch {t}"]
    running: true

    function getLastNumber(input) {
      // Split into lines and remove empty entries
      let lines = input.trim().split(/\r?\n/).filter(line => line.trim() !== "");
      if (lines.length === 0)
        return root.temp; // Keep old value if nothing valid yet

      let lastLine = lines[lines.length - 1];
      let num = parseInt(lastLine, 10);
      return isNaN(num) ? root.temp : num;
    }

    stdout: StdioCollector {
      id: stdio
      waitForEnd: false
      onTextChanged: root.temp = proc.getLastNumber(stdio.text)
    }
  }

  function setTemp(value: int) {
    value = Math.max(1000, Math.min(value, 6500));
    Quickshell.execDetached(["sh", "-c", `busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q ${value}`]);
  }

  function tempReset(): void {
    setTemp(6500);
  }
  function tempDown(value: int): void {
    Quickshell.execDetached(["sh", "-c", `busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -${value}`]);
  }
  function tempUp(value: int): void {
    Quickshell.execDetached(["sh", "-c", `busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +${value}`]);
  }
}
