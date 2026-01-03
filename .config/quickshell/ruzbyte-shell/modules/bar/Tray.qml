import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.config
import qs.modules.common

Item {
    id: root

    property var barWindow

    implicitWidth: rowLayout.implicitWidth
    implicitHeight: rowLayout.implicitHeight

    RowLayout {
        id: rowLayout

        spacing: 4
        anchors.centerIn: parent

        Repeater {
            model: SystemTray.items

            Rectangle {
                id: iconRect

                property var trayItem: modelData

                width: 25
                height: 22
                radius: 5
                color: Theme.bgSecondary

                IconImage {
                    anchors.centerIn: parent
                    visible: trayItem.icon !== ""
                    source: {
                        console.log("Tray Item Icon: " + trayItem.icon);
                        if (trayItem.title.includes("spotify")) {
                            console.log("Skipping Spotify icon to avoid redundancy.");
                            return "file://opt/spotify/icons/spotify-linux-24.png";
                        }
                        return trayItem.icon;
                    }
                    implicitSize: 16
                    mipmap: true
                }

                MouseArea {
                    id: trayMouseArea

                    anchors.fill: parent
                    anchors.centerIn: parent
                    width: parent.width + 2
                    height: parent.height
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    cursorShape: Qt.PointingHandCursor
                    onClicked: (mouse) => {
                        if (!trayItem)
                            return ;

                        if (mouse.button === Qt.LeftButton) {
                            if(trayItem.hasMenu) menuAnchor.toggle();
                        }
                    }
                    onEntered: {
                        tooltip.timer.start();
                        console.log("Starting tooltip timer for: " + trayItem.id);
                    }
                    onExited: {
                        tooltip.isShown = false;
                        tooltip.timer.stop();
                    }

                    Tooltip {
                        id: tooltip

                        property alias timer: tooltipTimer

                        anchor: parent

                        Timer {
                            id: tooltipTimer

                            running: false
                            interval: 500
                            onTriggered: parent.isShown = true
                        }

                        content: Text {
                            text: {
                                console.log(trayItem.title);
                                return trayItem.tooltipTitle ? trayItem.tooltipTitle : trayItem.title;
                            }
                            font.pixelSize: 12
                            color: Theme.fgPrimary
                        }

                    }

                    QsMenuAnchor {
                        id: menuAnchor

                        anchor.item: iconRect

                        function toggle() {
					        if (menuAnchor.visible) menuAnchor.close();
					        else menuAnchor.open();
				        }

				        function refresh() {
					        menuAnchor.open();
					        menuAnchor.close();
				        }

                        menu: trayItem.menu
                    }

                    QsMenuOpener {
                        id: menuOpener

                        readonly property bool hasIcon: children.values.some((e) => {
                            return e.icon;
                        })
                        readonly property bool hasButton: children.values.some((e) => {
                            return e.buttonType !== QsMenuButtonType.None;
                        })

                        menu: trayItem.menu
                    }
                }
            }
        }
    }

}
