import QtQuick 1.1

Item {
    id: root

    anchors.margins: orientation === Qt.Vertical
    width: (orientation === Qt.Vertical) ? platformStyle.paddingSmall : undefined
    height: (orientation === Qt.Horizontal) ? platformStyle.paddingSmall : undefined

    property real position
    property variant orientation: Qt.Vertical

    Rectangle {
        id: background
        anchors.fill: parent
        anchors.leftMargin: (orientation === Qt.Vertical && mouseArea.pressed) ?
                                root.width / 4 : 0
        anchors.topMargin: (orientation === Qt.Horizontal && mouseArea.pressed) ?
                               root.width / 4 : 0
        radius: (orientation === Qt.Vertical) ? width / 2 : height / 2
        color: "grey"
        opacity: mouseArea.pressed ? 0.3 : 0.25
    }

    Rectangle {
        height: platformStyle.graphicSizeMedium
        width: platformStyle.paddingSmall
//        x: (orientation === Qt.Vertical) ?
        radius: (orientation === Qt.Vertical) ? width / 2 : height / 2
        opacity: mouseArea.pressed ? 1 : 0.7
        color: mouseArea.pressed ? platformStyle.colorHighlighted : "grey"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag.target: parent
            drag.axis: (orientation === Qt.Vertical) ? Drag.YAxis : Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: root.width - parent.width
            drag.minimumY: 0
            drag.maximumY: root.height - parent.height
        }
    }
}
