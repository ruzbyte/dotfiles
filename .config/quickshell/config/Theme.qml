pragma Singleton

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Singleton {
    // Background colors
    property string bgPrimary: "#1a1b26"
    property string bgSecondary: "#24283b"
    property string bgTertiary: "#2e3440"
    property string bgSelected: "#364a82"
    property string bgMuted: "#565f89"

    // Foreground colors
    property string fgPrimary: "#c0caf5"
    property string fgMuted: "#808080"

    // Accent colors
    property string accentBlue: "#7aa2f7"
    property string accentPurple: "#bb9af7"
    property string accentGreen: "#9ece6a"
    property string accentRed: "#f7768e"

    // Border colors
    property string borderDefault: "#414868"
    property string borderAccent: "#7aa2f7"
}
