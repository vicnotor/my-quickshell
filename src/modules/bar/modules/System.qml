pragma ComponentBehavior: Bound

import "system" as System
import qs.config
import qs.modules.bar
import qs.services
import QtQuick

BarModule {
  id: root
  bg: Colors.palette.m3surfaceContainer

  property bool showPopup: false

  content: Row {
    spacing: Appearance.spacing.smaller
    anchors.verticalCenter: parent.verticalCenter
    System.Audio {
      anchors.verticalCenter: parent.verticalCenter
    }
    System.Brightness {
      anchors.verticalCenter: parent.verticalCenter
    }
    System.ScreenTemp {
      anchors.verticalCenter: parent.verticalCenter
    }
    System.Battery {
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
