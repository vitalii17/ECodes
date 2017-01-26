import QtQuick 1.1
import com.nokia.symbian 1.1

SelectionDialog {
    id: root

    property string currentdb

    delegate: MenuItem {
        text: model.display

        onClicked: {
            currentdb = model.display
            selectedIndex = index
            root.accept()
        }

        Image {
            id: checkBoxImage

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: platformStyle.paddingMedium
            source: "qrc:///gui/icons/accept.svg"
            visible: (selectedIndex === index) ?
                         true : false
            sourceSize.width: platformStyle.graphicSizeSmall
            sourceSize.height: platformStyle.graphicSizeSmall
        }
    }
}
