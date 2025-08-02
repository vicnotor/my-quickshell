import qs.widgets
import qs.services
import Quickshell

Scope {
  id: root

  // Audio
  CustomShortcut {
    name: "volumeUp"
    description: "Volume up"
    onPressed: Audio.setVolume(Audio.volume + 0.02)
  }
  CustomShortcut {
    name: "volumeDown"
    description: "Volume down"
    onPressed: Audio.setVolume(Audio.volume - 0.02)
  }
  CustomShortcut {
    name: "toggleMute"
    description: "Toggle mute audio"
    onPressed: Audio.toggleMute()
  }
  // Brightness

  CustomShortcut {
    name: "brightnessUp"
    description: "Increase brightness"
    onPressed: Brightness.changeBrightness(0.05)
  }
  CustomShortcut {
    name: "brightnessDown"
    description: "Decrease brightness"
    onPressed: Brightness.changeBrightness(-0.05)
  }
}
