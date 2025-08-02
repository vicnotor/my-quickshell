import "workspaces"
import qs.modules.bar
import QtQuick
import QtQuick.Layouts

BarModule {
  content: RowLayout {
    id: workspaces
    Workspaces {}
  }
}
