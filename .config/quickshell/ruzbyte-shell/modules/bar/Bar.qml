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


Scope {
    id: root

    property string user

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: bar

                required property var modelData

                screen: modelData
                implicitHeight: 38
                color: "transparent"

                anchors {
                    top: true
                    left: true
                    right: true
                }

                RowLayout {
                    id: rowLayout

                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 10

                    ClippingRectangle {
                        radius: 5
                        color: Theme.bgPrimary
                        Layout.fillHeight: true
                        implicitWidth: leftRow.implicitWidth + 20
                        border.color: Theme.borderDefault
                        border.width: 1
                        contentInsideBorder: true

                        RowLayout {
                            id: leftRow

                            anchors.centerIn: parent
                            spacing: 10

                            UserIcon {
                                id: userIcon
                            }

                            Clock {
                                id: clock
                            }
                        }

                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    ClippingRectangle {
                        Layout.fillHeight: true
                        implicitWidth: tray.implicitWidth + 20
                        radius: 5
                        color: Theme.bgPrimary
                        border.color: Theme.borderDefault
                        border.width: 1
                        contentInsideBorder: true

                        Tray {
                            id: tray
                            anchors.centerIn: parent
                            barWindow: bar
                        }

                    }

                    ClippingRectangle {
                        Layout.fillHeight: true
                        implicitWidth: systemIndicators.implicitWidth + 20
                        radius: 5
                        color: Theme.bgPrimary
                        border.color: Theme.borderDefault
                        border.width: 1
                        contentInsideBorder: true

                        SystemIndicators {
                            id: systemIndicators
                            anchors.centerIn: parent
                        }
                    }

                }

                ClippingRectangle {
                    radius: 5
                    color: Theme.bgPrimary
                    implicitWidth: workspaces.width + 20
                    implicitHeight: workspaces.height + 10
                    anchors.centerIn: parent
                    border.color: Theme.borderDefault
                    border.width: 1
                    contentInsideBorder: true
                    
                    /*
                    Behavior on implicitWidth {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutQuad
                        }
                    }
                    */

                    Workspaces {
                        id: workspaces
                        anchors.centerIn: parent
                    }

                }

            }

        }

    }

}
