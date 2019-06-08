import QtQuick 2.8
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import "SidePanels"
import "CustomComponents"
import "Popups"
import "Tabs/Tab1_Library"
import "Tabs/Tab2_AllApps"


ApplicationWindow{
    id: mainWindow
    visible: true
    minimumWidth: 900
    minimumHeight: 600

    flags: Qt.CustomizeWindowHint
    x: Screen.desktopAvailableWidth*0.5 - width*0.5
    y: Screen.desktopAvailableHeight*0.5 - height*0.5

    color: "transparent"//rFileSystem.BackgroundColor1

    Row{
        anchors.fill: parent
        Rectangle{
            id: sideBar
            width: 45
            height: parent.height
            color: "transparent"
            SidePanel{}
        }

        TabView{
            id: mainTabControl
            width: parent.width - sideBar.width
            height: parent.height
            tabsVisible: false
            frameVisible: true
            currentIndex: 0

            Tab{
                LibraryTab{}
            }

            Tab{
                AllAppsTab{}
            }
        }

    }

    NotificationPanel{
        id: notificationPanel
        width: mainTabControl.width*0.9
        height: mainTabControl.height*0.1
        x: sideBar.width + mainTabControl.width/2 - width/2
        oldY: mainWindow.height
        newY: mainWindow.height - height - 10

        Component.onCompleted: qtModel.updateDatabase(2)
    }
}
