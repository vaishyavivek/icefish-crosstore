import QtQuick 2.8
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

import "../../CustomComponents"
import "ChildTabs/OngoingProcesses"
import "ChildTabs/PreviouslyInstalled"

Item {
    id: allAppsTab

    Column{
        anchors.fill: parent

        Rectangle{
            id: tabHeaderParentRect
            width: parent.width
            height: 45
            color: "#49B0F9"
            /*gradient: Gradient{
                GradientStop{ position: 0.0; color: rFileSystem.BackgroundColor1}
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
                        width: 300
                        height: parent.height
                        orientation: ListView.Horizontal

                        model: ListModel{
                            ListElement{ title: "Ongoing Processes"}
                            ListElement{ title: "Previously Installed"}
                        }

                        delegate: Rectangle{
                            width: 150//title.length*12
                            height: parent.height
                            color: "transparent"

                            Text {
                                width: parent.width
                                height: parent.height
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                text: title
                                opacity: allAppsTabControl.currentIndex === index ? 1 : 0.75
                                font.pointSize: 12
                                font.bold: allAppsTabControl.currentIndex === index
                                //color: allAppsTabControl.currentIndex === index ? rFileSystem.HighlightColor : rFileSystem.IconColor
                                font.family: "Whitney"
                                color: rFileSystem.IconColor
                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: allAppsTabControl.currentIndex = index
                            }
                        }

                        currentIndex: allAppsTabControl.currentIndex
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
                }

                RWindowControlBar{
                    id: windowControlBar
                }
            }
        }

        TabView{
            id: allAppsTabControl
            width: parent.width
            height: parent.height - tabHeaderParentRect.height
            tabsVisible: false
            currentIndex: 0

            Tab{
                OngoingProcessesTab{}
            }

            Tab{
                PreviouslyInstalledTab{}
            }
        }
    }

}

