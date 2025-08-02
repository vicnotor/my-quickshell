import qs.widgets
import qs.services
import qs.config
import QtQuick

Column {
  id: root

  required property Brightness.Monitor monitor

  padding: Appearance.padding.large

  anchors.verticalCenter: parent.verticalCenter
  anchors.left: parent.left

  spacing: Appearance.spacing.normal

  VerticalSlider {
    icon: `brightness_${(Math.round(value * 6) + 1)}`
    value: root.monitor?.brightness ?? 0
    onMoved: root.monitor?.setBrightness(value)
  }
}
