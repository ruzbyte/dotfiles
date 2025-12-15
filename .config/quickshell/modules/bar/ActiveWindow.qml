import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.services

Item {
    id: root
    implicitWidth: rowLayout.implicitWidth
    implicitHeight: rowLayout.implicitHeight

    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    RowLayout {
        id: rowLayout
        spacing: 5

        ActiveWindowIcon {
            appId: root.activeWindow ? root.activeWindow.appId : ""
            implicitSize: 16
            mipmap: true
            visible: source !== ""
        }

        Text {
            font.pixelSize: 12
            color: "#c0caf5"
            elide: Text.ElideRight
            Layout.maximumWidth: 200
            Layout.minimumWidth: 50
            text: {
                if( root.activeWindow )  {
                    let title = root.activeWindow.title;
                    if (title.length > 30) {
                        return title.substring(0, 30) + "...";
                    }
                    return title;
                } 
                return "Desktop" 
            }
        }
    }
}