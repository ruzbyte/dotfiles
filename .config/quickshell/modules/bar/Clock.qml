import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.config

Item {
    id: root

    implicitWidth: clockText.implicitWidth
    implicitHeight: clockText.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        id: clockText

        color: Theme.fgPrimary
        font.pixelSize: 14
        font.bold: true
        text: Qt.formatDateTime(clock.date, "hh:mm")

    }

}
