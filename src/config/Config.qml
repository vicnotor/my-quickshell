pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  // bar
  readonly property int barHeight: 40
  readonly property int barModulesHeight: 32
  readonly property int barModulesInnerHeight: 24

  // slider
  readonly property int sliderWidth: 30
  readonly property int sliderHeight: 150
  readonly property int sliderTimeout: 2000
}
