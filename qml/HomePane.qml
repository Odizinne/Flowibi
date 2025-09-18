pragma ComponentBehavior: Bound
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick
import QtQuick.Layouts
import Odizinne.Flowibi
Pane {
    id: pane
    Material.background: "transparent"
    padding: 0
    property string descriptionText: "Waouh c'est une description de toi! C'est fou quand meme, on en fait des choses avec la technologie... Et c'est meme pas toi qui l'a écrite! wtf truc de dingue la"

    Rectangle {
        anchors.centerIn: parent
        width: 400
        height: 230
        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: 8
        }
        color: Common.altWindowColor
        radius: 8
        visible: !Common.isMobile
        GridLayout {
            anchors.fill: parent
            anchors.margins: 15
            columns: 2
            rows: 3
            rowSpacing: 15
            columnSpacing: 15
            Image {
                source: "qrc:/icons/zaza.png"
                Layout.preferredWidth: 128
                Layout.preferredHeight: 128
                Layout.row: 0
                Layout.column: 0
            }
            Label {
                Layout.row: 0
                Layout.column: 1
                Layout.rowSpan: 2
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: pane.descriptionText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignTop
                font.pixelSize: 18
            }
            Button {
                Layout.row: 2
                Layout.column: 0
                Layout.columnSpan: 2
                Layout.alignment: Qt.AlignCenter
                text: "Vers la gallerie"
                highlighted: true
                Material.foreground: "black"
                font.pixelSize: 20
                onClicked: {
                    Common.selectedButtonIndex = 1
                }
            }
        }
    }
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        height: mobileLyt.implicitHeight + 30
        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: 8
        }
        color: Common.altWindowColor
        radius: 8
        visible: Common.isMobile
        anchors.verticalCenter: parent.verticalCenter
        ColumnLayout {
            id: mobileLyt
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15
            Image {
                source: "qrc:/icons/zaza.png"
                Layout.preferredWidth: 128
                Layout.preferredHeight: 128
                Layout.alignment: Qt.AlignHCenter
            }
            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: pane.descriptionText
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: 18
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: "Vers la gallerie"
                highlighted: true
                Material.foreground: "black"
                font.pixelSize: 20
                onClicked: {
                    Common.selectedButtonIndex = 1
                }
            }
        }
    }
}
