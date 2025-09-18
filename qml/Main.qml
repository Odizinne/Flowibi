pragma ComponentBehavior: Bound

import QtQuick.Controls.Material
import QtQuick
import QtQuick.Layouts
import Odizinne.Flowibi

ApplicationWindow {
    id: root
    width: 1600
    height: 900
    visible: true
    title: qsTr("Flowibi")
    property int selectedButtonIndex: 0
    property int previousButtonIndex: 0
    property bool isMobile: width < 800
    onIsMobileChanged: {
        Common.isMobile = isMobile
    }

    Component.onCompleted: {
        Common.isMobile = isMobile
    }

    property int headerButtonsWidth: Math.max(accueilButton.implicitWidth, galerieButton.implicitWidth, contactButton.implicitWidth, socialButton.implicitWidth) + 20

    Material.accent: Common.accentColor
    color: Common.windowColor
    Material.primary: Common.primaryColor

    function switchToPage(index) {
        switch (index) {
        case 0: stackView.replace(accueilComponent); break
        case 1: stackView.replace(galerieComponent); break
        case 2: stackView.replace(contactComponent); break
        case 3: stackView.replace(socialComponent); break
        }
        previousButtonIndex = selectedButtonIndex
    }

    onSelectedButtonIndexChanged: {
        switchToPage(selectedButtonIndex)
    }

    BackgroundDots {
        id: dotPattern
        anchors.fill: parent
        z: -1
    }

    Component {
        id: accueilComponent
        HomePane { }
    }

    Component {
        id: galerieComponent
        GalleryPane { }
    }

    Component {
        id: contactComponent
        ContactPane { }
    }

    Component {
        id: socialComponent
        SocialPane { }
    }

    header: ToolBar {
        Material.elevation: 6
        height: 50

        Label {
            text: {
                switch(root.selectedButtonIndex) {
                    case 0: return "Accueil"
                    case 1: return "Galerie"
                    case 2: return "Contact"
                    case 3: return "Social"
                    default: return "Accueil"
                }
            }
            font.pixelSize: 18
            font.bold: true

            anchors.centerIn: parent
            visible: Common.isMobile
        }

        RowLayout {
            anchors.fill: parent

            RoundButton {
                id: menuButton
                text: "☰"
                flat: true
                visible: Common.isMobile
                onClicked: drawer.open()
                Layout.leftMargin: 10
            }

            RowLayout {
                id: buttonLayout
                Layout.alignment: Qt.AlignCenter
                visible: !Common.isMobile

                RoundButton {
                    id: accueilButton
                    text: "Accueil"
                    icon.source: "qrc:/icons/home.svg"
                    flat: true
                    Layout.preferredWidth: root.headerButtonsWidth
                    onClicked: {
                        accentLine.animationEnabled = (root.selectedButtonIndex !== 0)
                        root.selectedButtonIndex = 0
                    }
                }
                RoundButton {
                    id: galerieButton
                    text: "Galerie"
                    icon.source: "qrc:/icons/gallery.svg"
                    flat: true
                    Layout.preferredWidth: root.headerButtonsWidth
                    onClicked: {
                        accentLine.animationEnabled = (root.selectedButtonIndex !== 1)
                        root.selectedButtonIndex = 1
                    }
                }
                RoundButton {
                    id: contactButton
                    text: "Contact"
                    icon.source: "qrc:/icons/message.svg"
                    flat: true
                    Layout.preferredWidth: root.headerButtonsWidth
                    onClicked: {
                        accentLine.animationEnabled = (root.selectedButtonIndex !== 2)
                        root.selectedButtonIndex = 2
                    }
                }
                RoundButton {
                    id: socialButton
                    text: "Social"
                    icon.source: "qrc:/icons/person.svg"
                    flat: true
                    Layout.preferredWidth: root.headerButtonsWidth
                    onClicked: {
                        accentLine.animationEnabled = (root.selectedButtonIndex !== 3)
                        root.selectedButtonIndex = 3
                    }
                }
            }
        }

        Rectangle {
            id: accentLine
            height: 3
            width: accueilButton.width
            radius: 5
            color: "#15d15a"
            anchors.bottom: parent.bottom
            visible: !Common.isMobile

            property var buttons: [accueilButton, galerieButton, contactButton, socialButton]
            property real targetX: buttons[root.selectedButtonIndex].x + buttonLayout.x
            property bool animationEnabled: false

            Behavior on x {
                enabled: accentLine.animationEnabled
                NumberAnimation {
                    id: xAnimation
                    duration: 200
                    easing.type: Easing.OutCubic
                    onFinished: accentLine.animationEnabled = false
                }
            }

            Behavior on width {
                enabled: accentLine.animationEnabled
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            onTargetXChanged: {
                width = buttons[root.selectedButtonIndex].width
                x = targetX
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        popEnter: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200; easing.type: Easing.InQuint }
                NumberAnimation { property: "x"; from: (stackView.mirrored ? -0.3 : 0.3) * -stackView.width; to: 0; duration: 400; easing.type: Easing.OutCubic }
            }
        }

        popExit: Transition {
            NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 200; easing.type: Easing.OutQuint }
        }

        pushEnter: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200; easing.type: Easing.InQuint }
                NumberAnimation { property: "x"; from: (stackView.mirrored ? -0.3 : 0.3) * stackView.width; to: 0; duration: 400; easing.type: Easing.OutCubic }
            }
        }

        pushExit: Transition {
            NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 200; easing.type: Easing.OutQuint }
        }

        replaceEnter: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200; easing.type: Easing.InQuint }
                NumberAnimation { property: "x"; from: (stackView.mirrored ? -0.3 : 0.3) * stackView.width; to: 0; duration: 400; easing.type: Easing.OutCubic }
            }
        }

        replaceExit: Transition {
            NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 200; easing.type: Easing.OutQuint }
        }

        Component.onCompleted: {
            stackView.replace(accueilComponent)
        }
    }

    Drawer {
        id: drawer
        width: Math.min(parent.width * 0.8, 300)
        height: parent.height
        Material.roundedScale: Material.NotRounded

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            Text {
                text: "Menu"
                font.pixelSize: 24
                font.bold: true
                color: Material.primary
                anchors.horizontalCenter: parent.horizontalCenter
                bottomPadding: 20
            }

            RoundButton {
                text: "Accueil"
                width: parent.width
                flat: true
                highlighted: root.selectedButtonIndex === 0
                onClicked: {
                    root.selectedButtonIndex = 0
                    drawer.close()
                }
            }

            RoundButton {
                text: "Galerie"
                width: parent.width
                flat: true
                highlighted: root.selectedButtonIndex === 1
                onClicked: {
                    root.selectedButtonIndex = 1
                    drawer.close()
                }
            }

            RoundButton {
                text: "Contact"
                width: parent.width
                flat: true
                highlighted: root.selectedButtonIndex === 2
                onClicked: {
                    root.selectedButtonIndex = 2
                    drawer.close()
                }
            }

            RoundButton {
                text: "Social"
                width: parent.width
                flat: true
                highlighted: root.selectedButtonIndex === 3
                onClicked: {
                    root.selectedButtonIndex = 3
                    drawer.close()
                }
            }
        }
    }
}
