import QtQuick.Controls.Material
import QtQuick
import Odizinne.Flowibi

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
            highlighted: Common.selectedButtonIndex === 0
            onClicked: {
                Common.selectedButtonIndex = 0
                drawer.close()
            }
        }

        RoundButton {
            text: "Galerie"
            width: parent.width
            flat: true
            highlighted: Common.selectedButtonIndex === 1
            onClicked: {
                Common.selectedButtonIndex = 1
                drawer.close()
            }
        }

        RoundButton {
            text: "Contact"
            width: parent.width
            flat: true
            highlighted: Common.selectedButtonIndex === 2
            onClicked: {
                Common.selectedButtonIndex = 2
                drawer.close()
            }
        }

        RoundButton {
            text: "Social"
            width: parent.width
            flat: true
            highlighted: Common.selectedButtonIndex === 3
            onClicked: {
                Common.selectedButtonIndex = 3
                drawer.close()
            }
        }
    }
}
