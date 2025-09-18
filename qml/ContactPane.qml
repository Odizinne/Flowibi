pragma ComponentBehavior: Bound

import QtQuick.Controls.Material
import QtQuick
import QtQuick.Layouts
import Odizinne.Flowibi

Pane {
    id: pane
    Material.background: "transparent"
    padding: 0
    Label {
        text: "Contact"
        anchors.centerIn: parent
        font.pixelSize: 32
    }
}
