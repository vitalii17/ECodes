import QtQuick 1.1

TextLine {
    id: root

    property alias searchText: root.text
    property alias placeHolderText: root.placeHolderText

    leftSpace: searchImage.width + platformStyle.paddingSmall

    Image {
        id: searchImage
        source: "qrc:///gui/icons/search.svg"
        height: platformStyle.graphicSizeMedium - 2 * platformStyle.paddingSmall
        sourceSize.width: width
        sourceSize.height: height
        anchors.left: parent.left
        anchors.leftMargin: platformStyle.paddingSmall
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
    }

    onTextChanged: {
        if (text) {
            clearImage.state = "ClearVisible"
        } else {
            clearImage.state = "ClearHidden"
        }
    }

    Image {
        id: clearImage

        height: platformStyle.graphicSizeSmall
        width: platformStyle.graphicSizeSmall
        anchors.right: parent.right
        anchors.rightMargin: 2 * platformStyle.paddingMedium
        anchors.verticalCenter: parent.verticalCenter
        state: "ClearHidden"
        source: privateStyle.imagePath(
                    clearMouseArea.pressed ?
                        "qtg_graf_textfield_clear_pressed" :
                        "qtg_graf_textfield_clear_normal", root.platformInverted)
        MouseArea {
            id: clearMouseArea
            anchors.fill: parent
            onClicked: {
                root.focus = false
                root.cursorVisible = false
                root.closeSoftwareInputPanel()
                root.text = ""
                root.clearClicked()
                clearImage.state = "ClearHidden"
            }
        }

        states: [
            State {
                name: "ClearVisible"
                PropertyChanges {target: clearImage; opacity: 1}
            },
            State {
                name: "ClearHidden"
                PropertyChanges {target: clearImage; opacity: 0}
            }
        ]
    }
}
