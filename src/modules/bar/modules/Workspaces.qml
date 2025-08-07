import "workspaces"
import qs.modules.bar
import qs.services
import QtQuick
import QtQuick.Layouts

BarModule {
  bg: Colors.palette.m3surfaceContainer
  content: RowLayout {
    id: workspaces
    Workspaces {}
  }
}
