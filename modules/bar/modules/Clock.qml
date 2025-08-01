import qs.config
import qs.modules.bar
import qs.services
import QtQuick

BarModule {
  id: root
  content: Text {
    text: Time.time
    font.family: Appearance.font.family.sans
    color: Colors.palette.m3onSurface
  }
}
