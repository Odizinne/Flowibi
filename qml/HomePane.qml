pragma ComponentBehavior: Bound

import QtQuick.Controls.Material
import QtQuick
import QtQuick.Layouts
import Odizinne.Flowibi

Pane {
    id: pane
    Material.background: "transparent"//Common.windowColor
    padding: 0
    Label {
        text: "Accueil"
        anchors.centerIn: parent
        font.pixelSize: 32
    }
}
