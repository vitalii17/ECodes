import QtQuick 1.1

Rectangle {
    id: root

    anchors.left: parent.left
    anchors.right: parent.right
    height: platformStyle.graphicSizeMedium + 2 * platformStyle.paddingSmall
    color: platformStyle.colorNormalDark

    property int leftSpace: 0
    property int rightSpace: 0
    property alias text: textInput.text
    property alias placeHolderText: placeHolderText.text
    property bool cursorVisible: textInput.cursorVisible

    signal clearClicked

    function closeSoftwareInputPanel() {
        textInput.closeSoftwareInputPanel()
    }

    Rectangle {
        id: backgroundRect

        anchors.left: root.left
        anchors.leftMargin: platformStyle.paddingSmall + root.leftSpace
        anchors.right: root.right
        anchors.rightMargin: platformStyle.paddingMedium + root.rightSpace
        anchors.top: root.top
        anchors.topMargin: platformStyle.paddingSmall
        anchors.bottom: root.bottom
        anchors.bottomMargin: platformStyle.paddingSmall
        radius: platformStyle.paddingSmall
        color: platformStyle.colorNormalLight

        TextInput {
            id: textInput

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: platformStyle.paddingLarge
            anchors.right: parent.right
            anchors.rightMargin: platformStyle.paddingSmall
            color: platformStyle.colorNormalDark
            selectedTextColor: platformStyle.colorNormalLight
            selectionColor: platformStyle.colorTextSelection
            font.family: platformStyle.fontFamilyRegular
            font.pixelSize: platformStyle.fontSizeMedium
            selectByMouse: true
            activeFocusOnPress: false
            onActiveFocusChanged: {
                if (!textInput.activeFocus) {
                    textInput.closeSoftwareInputPanel()
                }
                else {
                    textInput.openSoftwareInputPanel()
                }
            }
        }

        Text {
            id: placeHolderText
            anchors.left: parent.left
            anchors.leftMargin: platformStyle.paddingMedium
            anchors.right: parent.right
            anchors.rightMargin: platformStyle.paddingMedium
            anchors.verticalCenter: parent.verticalCenter
            color: platformStyle.colorNormalMid
            font: textInput.font
            visible: (!textInput.activeFocus) && (!textInput.text) && text
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            anchors.leftMargin: root.leftSpace
            anchors.rightMargin: root.rightSpace

            onClicked: {
                textInput.focus = !textInput.focus
            }
        }
    }
}
