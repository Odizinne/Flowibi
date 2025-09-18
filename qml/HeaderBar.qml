import QtQuick.Controls.Material
import QtQuick.Controls.impl
import QtQuick
import QtQuick.Layouts
import Odizinne.Flowibi

ToolBar {
    id: root
    Material.elevation: 6
    height: 50
    signal openDrawer()
    property int headerButtonsWidth: Math.max(accueilButton.implicitWidth, galerieButton.implicitWidth, contactButton.implicitWidth, socialButton.implicitWidth) + 20

    IconLabel {
        text: {
            switch(Common.selectedButtonIndex) {
            case 0: return "Accueil"
            case 1: return "Galerie"
            case 2: return "Contact"
            case 3: return "Social"
            default: return "Accueil"
            }
        }
        icon.source: {
            switch(Common.selectedButtonIndex) {
            case 0: return "qrc:/icons/home.svg"
            case 1: return "qrc:/icons/gallery.svg"
            case 2: return "qrc:/icons/message.svg"
            case 3: return "qrc:/icons/person.svg"
            default: return "qrc:/icons/home.svg"
            }
        }
        spacing: 6
        font.pixelSize: 16
        icon.width: 20
        icon.height: 20
        anchors.centerIn: parent
        visible: Common.isMobile
    }

    RowLayout {
        anchors.fill: parent

        RoundButton {
            id: menuButton
            icon.source: "qrc:/icons/menu.svg"
            flat: true
            visible: Common.isMobile
            onClicked: root.openDrawer()
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
                font.pixelSize: 16
                icon.width: 20
                icon.height: 20
                Layout.preferredWidth: root.headerButtonsWidth
                onClicked: {
                    accentLine.animationEnabled = (Common.selectedButtonIndex !== 0)
                    Common.selectedButtonIndex = 0
                }
            }
            RoundButton {
                id: galerieButton
                text: "Galerie"
                icon.source: "qrc:/icons/gallery.svg"
                flat: true
                font.pixelSize: 16
                icon.width: 20
                icon.height: 20
                Layout.preferredWidth: root.headerButtonsWidth
                onClicked: {
                    accentLine.animationEnabled = (Common.selectedButtonIndex !== 1)
                    Common.selectedButtonIndex = 1
                }
            }
            RoundButton {
                id: contactButton
                text: "Contact"
                icon.source: "qrc:/icons/message.svg"
                flat: true
                font.pixelSize: 16
                icon.width: 20
                icon.height: 20
                Layout.preferredWidth: root.headerButtonsWidth
                onClicked: {
                    accentLine.animationEnabled = (Common.selectedButtonIndex !== 2)
                    Common.selectedButtonIndex = 2
                }
            }
            RoundButton {
                id: socialButton
                text: "Social"
                icon.source: "qrc:/icons/person.svg"
                flat: true
                font.pixelSize: 16
                icon.width: 20
                icon.height: 20
                Layout.preferredWidth: root.headerButtonsWidth
                onClicked: {
                    accentLine.animationEnabled = (Common.selectedButtonIndex !== 3)
                    Common.selectedButtonIndex = 3
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
        property real targetX: buttons[Common.selectedButtonIndex].x + buttonLayout.x
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
            width = buttons[Common.selectedButtonIndex].width
            x = targetX
        }
    }
}
