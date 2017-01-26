import QtQuick 1.1
import com.nokia.symbian 1.1

SelectionDialog {
    id: root

    property string currentDoc

    delegate: MenuItem {
        text: model.display

        onClicked: {
            root.accept()
        }
    }
}
