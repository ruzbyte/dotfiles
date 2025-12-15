import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.SystemTray
import Quickshell.Wayland
import Quickshell.Widgets

import qs.config

Item {
    id: root
    implicitWidth: rowLayout.width
    implicitHeight: rowLayout.height

    RowLayout {
        id: rowLayout
        spacing: 5
        anchors.centerIn: parent

        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                id: workspaceRect
                property var workspace: modelData
                property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === workspace.id

                Layout.preferredWidth: isActive ? (contentLayout.implicitWidth + 20) : 30
                Layout.preferredHeight: 22
                
                radius: 8
                color: isActive ? Theme.bgSelected : Theme.bgSecondary
                border.color: isActive ? Theme.borderAccent : "transparent"
                border.width: 1
                
                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }

                RowLayout {
                    id: contentLayout
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        text: workspace.id
                        color: workspaceRect.isActive ? Theme.fgPrimary : Theme.fgMuted
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Loader {
                        active: workspaceRect.isActive
                        visible: active
                        source: "ActiveWindow.qml"
                        
                        Layout.leftMargin: 5
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: workspace.activate()
                }
            }

        }

    }

}
