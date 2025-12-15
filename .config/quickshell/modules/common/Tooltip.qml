import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import qs.config

Item {
    id: root

    required property Item anchor
    required property Item content
    property bool isShown

    anchors.fill: anchor

    Loader {
        active: content

        sourceComponent: PopupWindow {
            id: popout

            visible: false
            implicitWidth: content.width + 2
            implicitHeight: content.height + 2
            color: "transparent"
            Component.onCompleted: {
                content.parent = contentWrapper;
                content.anchors.centerIn = contentWrapper;
            }

            Connections {
                function onIsShownChanged() {
                    if (isShown) {
                        popout.anchor.rect.x = root.parent.mouseX;
                        popout.anchor.rect.y = root.parent.mouseY + 20;
                        popout.visible = true;
                    } else {
                        popout.visible = false;
                    }
                }

                target: root
            }

            anchor {
                item: root

                rect {
                    x: root.width / 2 - content.width / 2 - 5
                    y: root.height + 6
                }

            }

            Rectangle {
                id: contentWrapper

                anchors.fill: parent
                radius: 5
                color: Theme.bgPrimary
                layer.enabled: true

                layer.effect: OpacityMask {

                    maskSource: Rectangle {
                        width: contentWrapper.width
                        height: contentWrapper.height
                        radius: contentWrapper.radius
                    }

                }

            }

            mask: Region {
            }

        }

    }

}
