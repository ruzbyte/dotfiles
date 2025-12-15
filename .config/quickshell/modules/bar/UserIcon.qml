import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.SystemTray
import Quickshell.Wayland
import Quickshell.Widgets

Item {
    id: root
    visible: user ? true : false
    property string user

    implicitWidth: userIcon.implicitWidth
    implicitHeight: userIcon.implicitHeight

    ClippingWrapperRectangle {
        radius: 5
        id: userIcon

        IconImage {
            asynchronous: true
            source: {
                const currentUser = root.user;
                console.log("Current User: " + parent.user);
                return "file:///home/" + currentUser + "/.face";
            }
            implicitSize: 22
            mipmap: true
        }

    }


    Process {
        id: userProc

        command: ["whoami"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.user = this.text.trim();
            }
        }

    }

}
