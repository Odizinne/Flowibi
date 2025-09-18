import QtQuick.Controls.Material
import QtQuick

StackView {
    id: stackView
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
}
