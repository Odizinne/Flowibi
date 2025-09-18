pragma ComponentBehavior: Bound
import QtQuick.Controls.Material
import QtQuick.Controls.impl
import QtQuick
import QtQuick.Layouts
import Odizinne.Flowibi

Pane {
    id: pane
    Material.background: "transparent"
    padding: 0

    property bool imageZoomed: false
    property string zoomedImageSource: ""
    property string zoomedImageDescription: ""

    ListModel {
        id: cardModel
        ListElement {
            cardImage: "qrc:/images/cat1.jpg"
            cardDescription: "C'est un chat"
        }
        ListElement {
            cardImage: "qrc:/images/cat2.jpg"
            cardDescription: "Un autre chat"
        }
        ListElement {
            cardImage: "qrc:/images/cat3.jpg"
            cardDescription: "Encore un chat"
        }
        ListElement {
            cardImage: "qrc:/images/cat4.jpg"
            cardDescription: "Ça fait beaucoup de chats... genre vraiment"
        }
        ListElement {
            cardImage: "qrc:/images/cat5.jpg"
            cardDescription: "Seriously???"
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: pane.imageZoomed ? ScrollBar.AlwaysOff : ScrollBar.AsNeeded

        ColumnLayout {
            width: pane.width
            spacing: 25
            Item {
                Layout.preferredHeight: 1
            }
            Repeater {
                model: cardModel
                delegate: ImageCard {
                    id: imgCard
                    required property var model
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: Common.isMobile ? pane.width / 1.3 : pane.width / 4
                    description: model.cardDescription
                    scale: cardImageMouseArea.containsMouse ? 1.05 : 1

                    Behavior on scale {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutQuad
                        }
                    }

                    Image {
                        id: cardImage
                        anchors.top: imgCard.top
                        anchors.left: imgCard.left
                        anchors.right: imgCard.right
                        height: imgCard.containerHeight
                        source: imgCard.model.cardImage
                        fillMode: Image.PreserveAspectCrop
                    }

                    MouseArea {
                        id: cardImageMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            pane.zoomedImageSource = imgCard.model.cardImage
                            pane.zoomedImageDescription = imgCard.model.cardDescription
                            pane.imageZoomed = true
                        }
                    }
                }
            }
            Item {
                Layout.preferredHeight: 1
            }
        }
    }

    // Mouse area to block scrolling when zoomed
    MouseArea {
        anchors.fill: parent
        visible: pane.imageZoomed
        onClicked: pane.imageZoomed = false
        onWheel: {} // Block wheel events
        preventStealing: true
    }

    // Dimmed background overlay
    Rectangle {
        id: dimOverlay
        anchors.fill: parent
        color: "#AA000000"
        visible: pane.imageZoomed || zoomedImage.scale > 0.1
        opacity: pane.imageZoomed ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    }

    // Zoomed image container
    Item {
        id: zoomedContainer
        anchors.fill: parent
        anchors.margins: 20
        visible: pane.imageZoomed || zoomedImage.scale > 0.1 || zoomedImage.opacity > 0

        Image {
            id: zoomedImage
            anchors.fill: parent
            source: pane.zoomedImageSource
            fillMode: Image.PreserveAspectFit
            smooth: true

            scale: pane.imageZoomed ? 1 : 0.1
            opacity: pane.imageZoomed ? 1 : 0

            // Description text inside the container
            Label {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 10
                text: pane.zoomedImageDescription
                color: "white"
                font.pixelSize: 18
                opacity: pane.imageZoomed ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutQuad
                    }
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 350
                    easing.type: Easing.OutQuad
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 350
                    easing.type: Easing.OutQuad
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: pane.imageZoomed = false
            }
        }
    }

    Item {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        width : 64
        height: 64
        opacity: pane.imageZoomed ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
        Rectangle {
            anchors.fill: parent
            radius: width
            color: "#1c1c1c"
            opacity: closeButtonMouseArea.containsMouse ? 0.8 : 0.5
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }
        }
        IconImage {
            anchors.centerIn: parent
            opacity: closeButtonMouseArea.containsMouse ? 1 : 0.7
            source: "qrc:/icons/cross.svg"
            color: "white"
            height: 32
            width: 32
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }
        }
        MouseArea {
            id: closeButtonMouseArea
            anchors.fill: parent
            anchors.margins: -10
            hoverEnabled: true
            onClicked: pane.imageZoomed = false
            cursorShape: Qt.PointingHandCursor
        }
    }
}
