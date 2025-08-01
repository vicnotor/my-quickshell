import "workspaces"
import qs.config
import qs.modules.bar
import QtQuick
import QtQuick.Layouts

BarModule {
  content: RowLayout {
    id: workspaces
    spacing: Appearance.spacing.small
    Workspaces {}
  }
}
