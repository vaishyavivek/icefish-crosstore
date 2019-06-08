import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

import "../../CustomComponents"
import "ChildTabs/Home"
import "ChildTabs/Latest"
import "ChildTabs/Trending"
import "ChildTabs/SearchResult"
import "ChildTabs/AppDetails"

Item {
    id: libraryTab

    Column{
        anchors.fill: parent

        Rectangle{
            id: tabHeaderParentRect
            width: parent.width
            height: 45
            color: "#49B0F9"
            //opacity: 0.5
            /*gradient: Gradient{

                GradientStop{ position: 0.0; color: "#49B0F9"}//}rFileSystem.BackgroundColor1}
                GradientStop{ position: 0.99; color: rFileSystem.BackgroundColor2 }
            }*/

            Row{
                anchors.fill: parent
                spacing: 5
                Rectangle{
                    width: parent.width - windowControlBar.width
                    height: parent.height
                    color: "transparent"
                    ListView{
                        id: appTypeListView
                        width: 180
                        height: parent.height
                        orientation: ListView.Horizontal

                        model: ListModel{
                            ListElement{ title: "Home"}
                            ListElement{ title: "Latest"}
                            ListElement{ title: "Trending"}
                        }

                        delegate: Rectangle{
                            width: 60//title.length*12
                            height: parent.height
                            color: "transparent"

                            Text {
                                width: parent.width
                                height: parent.height
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                text: title
                                opacity: libraryTabControl.currentIndex === index ? 1 : 0.75
                                font.pointSize: 14
                                font.bold: libraryTabControl.currentIndex === index
                                font.family: "Whitney"
                                //color: libraryTabControl.currentIndex === index ? rFileSystem.HighlightColor : "white"//rFileSystem.IconColor
                                color: rFileSystem.IconColor
                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: libraryTabControl.currentIndex = index
                            }


                        }

                        currentIndex: libraryTabControl.currentIndex
                        highlightFollowsCurrentItem: true
                        highlightMoveDuration: rFileSystem.GlobalAnimationDuration
                        highlight: Rectangle{
                            width: 60//title.length*12
                            height: parent.height
                            color: "transparent"

                            Rectangle{
                                width: parent.width*0.8
                                height: 2
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: rFileSystem.IconColor
                                //visible: libraryTabControl.currentIndex === index
                            }
                        }
                    }

                    TextField{
                        id: textField
                        anchors.right: parent.right
                        width: 250
                        height: 35
                        anchors.verticalCenter: parent.verticalCenter
                        placeholderText: "Search your favorite app here..."
                        KeyNavigation.tab: libraryTabControl

                        onAccepted: {
                            qtModel.searchApp(text)
                            libraryTabControl.currentIndex = 3
                        }
                    }
                }

                RWindowControlBar{
                    id: windowControlBar
                }
            }
        }

        TabView{
            id: libraryTabControl
            width: parent.width
            height: parent.height - tabHeaderParentRect.height
            tabsVisible: false
            currentIndex: 0

            Tab{
                HomeTab{}
            }

            Tab{
                LatestTab{}
            }

            Tab{
                TrendingTab{}
            }

            Tab{
                SearchResultTab{}
            }

            Tab{
                AppDetailsPage{}
            }
        }
    }

}
