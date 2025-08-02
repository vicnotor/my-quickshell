import qs.services
import QtQuick

Item {
  BrightnessSlider {
    monitor: Brightness.monitors[0]
  }
}
