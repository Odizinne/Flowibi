pragma ComponentBehavior: Bound

import QtQuick.Controls.Material
import QtQuick
import QtQuick.Layouts
import Odizinne.Flowibi

Pane {
    id: pane
    Material.background: Common.windowColor
    padding: 0

    ListModel {
        id: cardModel
        ListElement {
            cardImage: "image1.jpg"
            cardDescription: "First image description"
        }
        ListElement {
            cardImage: "image2.jpg"
            cardDescription: "Second image description"
        }
        ListElement {
            cardImage: "image3.jpg"
            cardDescription: "Third image description"
        }
        ListElement {
            cardImage: "image4.jpg"
            cardDescription: "Fourth image description"
        }
        ListElement {
            cardImage: "image5.jpg"
            cardDescription: "Fifth image description"
        }
    }

    ScrollView {
        anchors.fill: parent

        ColumnLayout {
            width: pane.width
            spacing: 25
            Item {
                Layout.preferredHeight: 1
            }

            Repeater {
                model: cardModel
                delegate: ImageCard {
                    required property var model
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: pane.width / 4
                    description: model.cardDescription

                    Rectangle {
                        // add image here, on clicked, show full available size, dimm background
                    }
                }
            }

            Item {
                Layout.preferredHeight: 1
            }
        }
    }
}
