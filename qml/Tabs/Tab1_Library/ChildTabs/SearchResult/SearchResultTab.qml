import QtQuick 2.12
import "../../../../CustomComponents"

Rectangle {
    id: searchResultTab
    color: rFileSystem.BackgroundColor2

    Column{
        anchors.fill: parent
        anchors.margins: 5
        spacing: 10

        Rectangle{
            id: filterRect
            width: parent.width
            height: 45
            color: "transparent"

            Row{
                anchors.fill: parent
                anchors.margins: 5
                spacing: 5
                Rectangle{
                    id: spacing
                    width: parent.width - 360
                    height: parent.height
                    color: "transparent"
                }

                RComboBox{
                    id: licenceTypeBox
                    width: 175
                    height: parent.height
                    model: ["Any License", "Open Source (Free)", "Custom (Paid or Propriatory)"]
                    onCurrentIndexChanged: qtModel.searchApp(textField.text, categoryBox.currentText, currentIndex)
                }

                RComboBox{
                    id: categoryBox
                    width: 175
                    height: parent.height
                    model: ["All Categories", "Audio Player", "Backup and Recovery", "Cloud Storage", "Commandline Editors", "Download Manager",
                            "Email Client", "Finance Software", "Gaming", "Hypervisor", "IDE Editors", "Image Editor", "Instant Messaging",
                            "Linux Antivirus", "Linux Desktop Environments", "Linux Terminal", "Multimedia Editors", "Network Scanner",
                            "Note Taking", "Office Suite", "Screen Recorders", "Screenshot Tools", "Security", "Software", "Text Editors",
                            "Torrent Client", "Video Editor", "Video Players", "Virtualization Tools", "Web Browser", "Widget Toolkit"]
                    onCurrentTextChanged: qtModel.searchApp(textField.text, currentText, licenceTypeBox.currentIndex)
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 10
            color: "transparent"

            Text {
                text: "  Showing " + searchResultListView.count + " Entrie(s)"
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 9
                color: "grey"
                width: parent.width
                height: parent.height
            }
        }

        ListView{
            id: searchResultListView
            width: parent.width
            height: parent.height - filterRect.height - 30
            //anchors.margins: 10
            model: qtModel.SearchResultList
            spacing: 10
            clip: true


            delegate: Rectangle{
                width: parent.width
                height: 70
                color: "transparent"

                Row{
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10
                    Rectangle{
                        height: parent.height
                        width: height
                        color: "transparent"
                        Image {
                            id: logo
                            anchors.fill: parent
                            source: "image://xdg/" + model.packageName
                            sourceSize.width: width*0.8
                            sourceSize.height: height*0.8
                        }
                    }

                    Rectangle{
                        height: parent.height
                        width: parent.width - height*3 - 20
                        color: "transparent"

                        Column{
                            anchors.fill: parent
                            spacing: 5
                            Rectangle{
                                width: parent.width
                                height: 15
                                color: "transparent"
                                Text {
                                    id: name
                                    text: model.friendlyName
                                    font.bold: true
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 14
                                    width: parent.width
                                    height: parent.height
                                }
                            }
                            Rectangle{
                                width: parent.width
                                height: 10
                                color: "transparent"
                                Text {
                                    id: publisher
                                    text: model.publisher
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 10
                                    width: parent.width
                                    height: parent.height
                                    color: "navy"
                                }
                            }
                            Rectangle{
                                width: parent.width
                                height: 20
                                color: "transparent"
                                Text {
                                    id: description_short
                                    text: model.descriptionShort
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 10
                                    width: parent.width
                                    height: parent.height
                                    color: "grey"
                                }
                            }
                        }
                    }

                    Rectangle{
                        height: parent.height
                        width: height*2
                        color: "transparent"
                        Column{
                            anchors.fill: parent
                            anchors.topMargin: 10
                            spacing: 10
                            RTextButton{
                                id: showDetailsBtn
                                width: parent.width
                                height: 25
                                text: "Show Details"
                                z: 2
                                onClicked: {
                                    qtModel.showAppDetails(index)
                                    libraryTabControl.currentIndex = 4
                                }
                            }

                            Rectangle{
                                width: parent.width
                                height: 15
                                color: "transparent"
                                Text {
                                    id: category
                                    text: model.category
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 10
                                    width: parent.width
                                    height: parent.height
                                }
                            }
                        }
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    z: -1
                    onEntered: mouseEnteredAnimation.start()
                    onExited: mouseExitedAnimation.start()
                    onClicked: searchResultListView.currentIndex = index
                }

                Rectangle{
                    id: animatingRect
                    anchors.fill: parent
                    radius: 5
                    opacity: 0.1
                    color: "transparent"
                    border.width: 2
                    border.color: "grey"
                }

                PropertyAnimation{
                    id: mouseEnteredAnimation
                    target: animatingRect
                    property: "color"
                    easing.type: Easing.OutInQuad
                    to: rFileSystem.HighlightColor
                    duration: rFileSystem.GlobalAnimationDuration
                }
                PropertyAnimation{
                    id: mouseExitedAnimation
                    target: animatingRect
                    property: "color"
                    easing.type: Easing.OutInQuad
                    to: "transparent"
                    duration: rFileSystem.GlobalAnimationDuration
                }
            }

            highlightFollowsCurrentItem: true
            keyNavigationEnabled: true
            highlight: Rectangle{
                width: searchResultListView.width
                height: 70
                color: rFileSystem.SelectedColor
                opacity: 0.4
                radius: 5
            }
        }
    }
}
