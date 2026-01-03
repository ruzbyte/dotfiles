import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.config

RowLayout {
    spacing: 5

    // Helper component for buttons
    component SystemButton: Rectangle {
        property string icon
        property color iconColor: Theme.fgPrimary
        signal clicked

        width: 25
        height: 22
        radius: 5
        color: Theme.bgSecondary
        
        Text {
            anchors.centerIn: parent
            text: parent.icon
            color: parent.iconColor
            font.pixelSize: 14
        }
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.clicked()
        }
    }

    SystemButton {
        icon: "󰤨"
        onClicked: Process.start("nm-connection-editor")
    }

    SystemButton {
        icon: "󰕾"
        onClicked: Process.start("pavucontrol")
    }

    SystemButton {
        icon: "󰂚"
        onClicked: console.log("Notifications clicked") 
    }

    SystemButton {
        icon: ""
        iconColor: Theme.accentRed
        onClicked: Process.start("wlogout")
    }
}
