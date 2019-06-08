import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtWebKit 3.0
import "../../../../CustomComponents"

Rectangle {
    id: appDetailsPage
    color: rFileSystem.BackgroundColor2

    Column{
        anchors.fill: parent

        Rectangle{
            id: navigationBar
            width: parent.width
            height: 35
            color: "transparent"

            RImageButton{
                id: backBtn
                height: parent.height
                width: height
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "/local/assets/back-arrow.svg"
                onClicked: libraryTabControl.currentIndex = 3
            }

            ListView{
                id: appDetailsPageTabViewHeaderListView
                width: 195
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5
                orientation: ListView.Horizontal
                anchors.horizontalCenter: parent.horizontalCenter

                model: ListModel{
                    ListElement{ title: "Overview" }
                    ListElement{ title: "Ratings" }
                    ListElement{ title: "Related" }
                }

                delegate: Rectangle{
                    width: 60
                    height: parent.height
                    color: "transparent"
                    Text {
                        text: title
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 11
                        width: parent.width
                        height: parent.height
                        opacity: appDetailsPageTabView.currentIndex == index ? 1 : 0.75
                        color: appDetailsPageTabView.currentIndex == index ? rFileSystem.SelectedColor : "grey"
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: appDetailsPageTabView.currentIndex = index
                    }

                    Rectangle{
                        width: parent.width*0.8
                        height: 2
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: rFileSystem.SelectedColor
                        visible: appDetailsPageTabView.currentIndex === index
                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 1
            color: "grey"
        }

        TabView{
            id: appDetailsPageTabView
            width: parent.width
            height: parent.height - 20
            tabsVisible: false
            currentIndex: 0

            Tab{
                id: overview
                OverviewTab{}
            }

            Tab{
                id: ratings
            }

            Tab{
                id: related
            }
        }
    }

}
