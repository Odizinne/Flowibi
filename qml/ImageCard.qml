import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import Odizinne.Flowibi

Rectangle {
    id: imageCard
    height: width * 1.25
    implicitWidth: 200
    implicitHeight: width * 1.25
    layer.enabled: true
    layer.effect: ElevationEffect {
        elevation: 8
    }
    color: Common.primaryColor
    radius: width * 0.02  // 8px when width is 200px
    property string description: ""
    property string image: ""
    readonly property int containerWidth: container.width
    readonly property int containerHeight: container.height

    Rectangle {
        id: container
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.width
        width: parent.width
        clip: true
        color: Common.accentColor
        topLeftRadius: parent.radius
        topRightRadius: parent.radius
        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }

    Label {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height - parent.width
        text: imageCard.description
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: parent.width * 0.08
        wrapMode: Text.WordWrap
    }
}
