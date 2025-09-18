pragma ComponentBehavior: Bound

import QtQuick.Controls.Material
import QtQuick
import Odizinne.Flowibi

ApplicationWindow {
    id: root
    width: 1600
    height: 900
    visible: true
    title: qsTr("Flowibi")
    color: Common.windowColor
    Material.accent: Common.accentColor
    Material.primary: Common.primaryColor

    header: HeaderBar {
        onOpenDrawer: drawer.open()
    }

    function switchToPage(index) {
        switch (index) {
        case 0: stackView.replace(accueilComponent); break
        case 1: stackView.replace(galerieComponent); break
        case 2: stackView.replace(contactComponent); break
        case 3: stackView.replace(socialComponent); break
        }
        Common.previousButtonIndex = Common.selectedButtonIndex
    }

    Binding {
        target: Common
        property: "isMobile"
        value: root.width < 800
    }

    Connections {
        target: Common
        function onSelectedButtonIndexChanged() {
            root.switchToPage(Common.selectedButtonIndex)
        }
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

    CustomStackView {
        id: stackView
        anchors.fill: parent
        initialItem: accueilComponent
    }

    SidebarNavigation {
        id: drawer
    }
}
