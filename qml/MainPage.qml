import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import EcodesModel 1.0
import SortFilterProxyModel 1.0
import "DynamicObject.js" as DynamicObject

Page {
    id: mainPage

//    SearchBox {
//        id: searchBox
//        anchors.top: parent.top
//        placeHolderText: qsTr("Find...")
//        z: 1
//    }

    SearchLine {
        id: searchBox
        anchors.top: parent.top
        placeHolderText: qsTr("Find...")
        z: 1
    }

    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: searchBox.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: scrollBar.width

        property string currentCode
        property string currentName
        property string currentPurpose
        property string currentStatus

        model: proxyModel

        delegate: ListItem {

            onClicked: {
                listView.currentCode    = model.code
                listView.currentName    = model.name
                listView.currentPurpose = model.purpose
                listView.currentStatus  = model.status
                detailDialog.open()
            }

            Rectangle {
                id: colorRect
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                width: 10
                color: "transparent"
                Component.onCompleted: {
                    if(model.status.length === 0) {color = "red"}
                    if((model.status.indexOf("pproved") === -1) &&
                            (model.status.indexOf("хвален") === -1)) {
                        color = "red"
                    }
                    if((model.status.indexOf("anned") !== -1) ||
                            (model.status.indexOf("аборонен") !== -1)) {
                        color = "red"
                    }
                }
            }

            Column {
                anchors.top: parent.top
                anchors.left: colorRect.right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.topMargin: spacing
                anchors.bottomMargin: spacing
                anchors.leftMargin: 5
                spacing: (parent.height -
                          title.height -
                          subTitle.height) / 3

                ListItemText {
                    id: title
                    role: "Title"
                    text: model.code
                    font.pixelSize: platformStyle.fontSizeLarge
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
                ListItemText {
                    id: subTitle
                    role: "SubTitle"
                    text: model.name
                    font.pixelSize: platformStyle.fontSizeMedium
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }

    SortFilterProxyModel {
        id: proxyModel
        source: ecodesModel.count > 0 ? ecodesModel : null
        filterString: searchBox.searchText
        filterSyntax: SortFilterProxyModel.Wildcard
        filterCaseSensitivity: Qt.CaseInsensitive
    }

    EcodesModel {
        id: ecodesModel
        source: "qrc:///db/database/" + settings.currentdb
    }

    ScrollBar {
        id: scrollBar
        anchors.right: mainPage.right
        anchors.top: listView.top
        anchors.bottom: listView.bottom
        flickableItem: listView
        interactive: false
        policy: Symbian.ScrollBarWhenNeeded
    }

    ContextMenu {
        id: isearchContextMenu

        property string searchItem
        property string local: "en"

        MenuLayout {
            MenuItem {
                text: "Wikipedia.org"
                onClicked: Qt.openUrlExternally("https://" +
                                                isearchContextMenu.local +
                                                ".wikipedia.org/wiki/" +
                                                isearchContextMenu.searchItem)
            }
            MenuItem {
                text: "Google.com"
                onClicked: Qt.openUrlExternally("https://google.com/?gws_rd=ssl#q=" +
                                                isearchContextMenu.searchItem)
            }
        }
    }

    DetailDialog {
        id: detailDialog
        titleText: listView.currentCode + " - " + listView.currentName
        height: (mainPage.height > mainPage.width) ? mainPage.height / 2 :
                                                     mainPage.height / 1.25
        buttonTexts: [qsTr("Close")/*, qsTr("More")*/]

        onButtonClicked: {
            if(buttonTexts[index] === qsTr("More")) {
                isearchContextMenu.searchItem = currentCode
                isearchContextMenu.open()
            }
        }

        currentCode:    listView.currentCode
        currentName:    listView.currentName
        currentPurpose: listView.currentPurpose
        currentStatus:  listView.currentStatus
    }

    DBSelectionDialog {
        id: dbSelectionDialog
        titleText: qsTr("Select database")
        model: dbListModel
        selectedIndex: dbListModel.indexOf(settings.currentdb)
        onSelectedIndexChanged: settings.currentdb = dbListModel.get(selectedIndex)
    }

    DocsSelectionDialog {
        id: docsSelectionDialog
        titleText: qsTr("Select document")
        model: docsListModel
        onAccepted: {
//            docsViewer.file = "qrc:///regulations/regulations/" + docsListModel.get(selectedIndex)
//            window.pageStack.push(docsViewer)

            var docsPageObject =
                    DynamicObject.create(window, "DocumentViewerPage.qml")
            window.pageStack.push(docsPageObject)
            docsPageObject.back.connect(window.pageStack.pop)
//            docsPageObject.back.connect(docsPageObject.destruct)
        }
    }

    tools: ToolBarLayout {
        CustomToolButton {
            iconSource: "toolbar-back"
            toolTip: toolTip
            toolTipText: qsTr("Exit")
            onClicked: Qt.quit()
        }
        CustomToolButton {
            iconSource: "toolbar-menu"
            toolTip: toolTip
            toolTipText: qsTr("Menu")
            onClicked: menu.open()
        }
    }

    ToolTip {
        id: toolTip
        visible: false
    }

    Menu {
        id: menu
        MenuLayout {
            MenuItem {
                text: qsTr("Regulations")
                onClicked: docsSelectionDialog.open()
            }
            MenuItem
            {
                text: qsTr("Database")
                onClicked: dbSelectionDialog.open()
            }
            MenuItem {
                text: qsTr("About")
                onClicked: {
                    var aboutPageObject =
                            DynamicObject.create(window, "AboutPage.qml")
                    window.pageStack.push(aboutPageObject)
                    aboutPageObject.back.connect(window.pageStack.pop)
                    aboutPageObject.back.connect(aboutPageObject.destruct)
                }
            }
        }
    }
}
