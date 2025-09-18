import QtQuick
import Odizinne.Flowibi

Item {
    id: dotPattern
    z: -1

    property int dotSize: 12
    property int spacing: 80
    property color dotColor: Common.patternColor
    onWidthChanged: patternCanvas.requestPaint()
    onHeightChanged: patternCanvas.requestPaint()

    Canvas {
        id: patternCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            ctx.fillStyle = dotPattern.dotColor

            // Calculate diagonal spacing (rotated square grid)
            var diagonalSpacing = dotPattern.spacing * Math.sqrt(2)
            var halfDiagonal = diagonalSpacing / 2

            // Calculate how many rows and columns we need to cover the entire area
            var maxDimension = Math.max(width, height)
            var gridSize = Math.ceil(maxDimension / halfDiagonal) + 4

            for (var i = -gridSize; i < gridSize; i++) {
                for (var j = -gridSize; j < gridSize; j++) {
                    // Calculate position for rotated grid
                    var x = (i * halfDiagonal) + (j * halfDiagonal)
                    var y = (j * halfDiagonal) - (i * halfDiagonal)

                    // Offset to center and ensure coverage
                    x += width / 2
                    y += height / 2

                    // Only draw dots that are visible
                    if (x >= -dotPattern.dotSize && x <= width + dotPattern.dotSize &&
                        y >= -dotPattern.dotSize && y <= height + dotPattern.dotSize) {
                        ctx.beginPath()
                        ctx.arc(x, y, dotPattern.dotSize / 2, 0, 2 * Math.PI)
                        ctx.fill()
                    }
                }
            }
        }

        Component.onCompleted: requestPaint()
    }
}
