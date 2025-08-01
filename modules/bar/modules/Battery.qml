import qs.config
import qs.modules.bar
import qs.services
import QtQuick

BarModule {
  id: root
  content: Text {
    id: label
    text: BatteryStatus.text
    font.family: Appearance.font.family.sans
    color: Colors.palette.m3onSurface
  }
}
