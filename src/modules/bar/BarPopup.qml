pragma ComponentBehavior: Bound

import qs.config
import qs.services
import QtQuick
import Quickshell

LazyLoader {
  id: root
  active: root.showPopup

  required property Item content
  required property bool showPopup
  required property var anchorItem
  property var anchorY: root.anchorItem.height

  property var padding: Appearance.padding.smaller
  property color bg: Colors.palette.m3surface

  PopupWindow {
    visible: true
    anchor.item: root.anchorItem
    anchor.rect.x: root.anchorItem.width / 2 - width / 2
    anchor.rect.y: root.anchorY
    color: "transparent"
    implicitHeight: contentContainer.implicitHeight + root.padding * 2
    implicitWidth: contentContainer.implicitWidth + root.padding * 2

    Rectangle {
      anchors.fill: parent
      color: root.bg
      radius: Appearance.rounding.small
    }

    Item {
      id: contentContainer
      implicitWidth: root.content.implicitWidth
      implicitHeight: root.content.implicitHeight
      anchors.centerIn: parent
      children: [root.content]
    }
  }
}
