import QtQuick 1.1
import com.nokia.symbian 1.1
import QtWebKit 1.0

Page {
    id: root

    property alias file: webView.url

    signal back

    function destruct() {
        root.destroy()
    }

    Flickable {
        id: flickable

        width: root.width
        contentWidth: Math.max(root.width, webView.width)
        contentHeight: Math.max(root.height, webView.height)
        anchors.fill: root
        boundsBehavior: Flickable.StopAtBounds

        WebView {
            id: webView

            preferredWidth: flickable.width
            preferredHeight: flickable.height
            //            scale: 1.5
            contentsScale: 1.2
            //    smooth: true
            settings.pluginsEnabled: false
            settings.javaEnabled: false
            settings.javascriptEnabled: false
            settings.autoLoadImages: true
        }
    }

    ScrollBar {
        id: vScrollBar
        anchors.right: flickable.right
        anchors.top: flickable.top
        anchors.bottom: flickable.bottom
        flickableItem: flickable
        interactive: false
        policy: Symbian.ScrollBarWhenNeeded
        orientation: Qt.Vertical
    }

    ScrollBar {
        id: hScrollBar
        anchors.right: flickable.right
        anchors.left: flickable.left
        anchors.bottom: flickable.bottom
        flickableItem: flickable
        interactive: false
        policy: Symbian.ScrollBarWhenNeeded
        orientation: Qt.Horizontal
    }

    tools: ToolBarLayout {
        CustomToolButton {
            iconSource: "toolbar-back"
            toolTip: toolTip
            toolTipText: qsTr("Back")
            onClicked: {
                back()
            }
        }
    }

    ToolTip {
        id: toolTip
        visible: false
    }
}
