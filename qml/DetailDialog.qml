import QtQuick 1.1
import com.nokia.symbian 1.1

CommonDialog {
    id: root
    onClickedOutside: close()

    property string currentCode
    property string currentName
    property string currentPurpose
    property string currentStatus

    content: Flickable {
        anchors.fill: parent
        anchors.leftMargin: platformStyle.paddingLarge
        anchors.topMargin: platformStyle.paddingLarge
        anchors.rightMargin: platformStyle.paddingLarge
        contentWidth: width
        contentHeight: column.height
        interactive: contentHeight > height

        MouseArea {
            anchors.fill: parent
            onClicked: root.close()
        }

        Column {
            id: column
            width: parent.width
            spacing: platformStyle.paddingMedium

            Text {
                text: qsTr("Code") + ": " + root.currentCode
                width: parent.width
                wrapMode: Text.WordWrap
                font.family: platformStyle.fontFamilyRegular
                font.pixelSize: platformStyle.fontSizeLarge
                color: parent.platformInverted ?
                           platformStyle.colorNormalLightInverted :
                           platformStyle.colorNormalLight
            }

            Text {
                text: qsTr("Name") + ": " + root.currentName
                width: parent.width
                wrapMode: Text.WordWrap
                font.family: platformStyle.fontFamilyRegular
                font.pixelSize: platformStyle.fontSizeLarge
                color: parent.platformInverted ?
                           platformStyle.colorNormalLightInverted :
                           platformStyle.colorNormalLight
            }

            Text {
                text: qsTr("Purpose") + ": " + root.currentPurpose
                width: parent.width
                wrapMode: Text.WordWrap
                font.family: platformStyle.fontFamilyRegular
                font.pixelSize: platformStyle.fontSizeLarge
                color: parent.platformInverted ?
                           platformStyle.colorNormalLightInverted :
                           platformStyle.colorNormalLight
            }

            Text {
                text: (root.currentStatus.length !== 0) ?
                          qsTr("Status") + ": " + root.currentStatus :
                          qsTr("Status") + ": " + qsTr("Not approved!")
                width: parent.width
                wrapMode: Text.WordWrap
                font.family: platformStyle.fontFamilyRegular
                font.pixelSize: platformStyle.fontSizeLarge
                color: parent.platformInverted ?
                           platformStyle.colorNormalLightInverted :
                           platformStyle.colorNormalLight
            }
        }
    }
}
