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
  CustomShortcut {
    name: "micVolumeUp"
    description: "Mic volume up"
    onPressed: Audio.setMicVolume(Audio.micVolume + 0.02)
  }
  CustomShortcut {
    name: "micVolumeDown"
    description: "Mic volume down"
    onPressed: Audio.setMicVolume(Audio.micVolume - 0.02)
  }
  CustomShortcut {
    name: "toggleMicMute"
    description: "Toggle mic mute audio"
    onPressed: Audio.toggleMicMute()
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

  // Brightness
  CustomShortcut {
    name: "tempUp"
    description: "Increase light temperature"
    onPressed: ScreenTemp.tempUp(100)
  }
  CustomShortcut {
    name: "tempDown"
    description: "Decrease light temperature"
    onPressed: ScreenTemp.tempDown(100)
  }
  CustomShortcut {
    name: "tempReset"
    description: "Decrease light temperature"
    onPressed: ScreenTemp.tempReset()
  }
}
