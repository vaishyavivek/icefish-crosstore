import QtQuick 2.7

import "../../../../CustomComponents"

Item {
    id: ongoingProcessesTab
    Column{
        anchors.fill: parent
        anchors.topMargin: 5
        spacing: 5

        Rectangle{
            id: controlBar
            width: parent.width
            height: 30
            color: "transparent"

            RTextButton{
                id: hybridBtn
                height: parent.height
                width: 120
                anchors.right: parent.right
                anchors.rightMargin: 10
                text: "Check for Updates"
                onClicked: libraryTabControl.currentIndex = 3
            }
        }

        Rectangle{
            width: parent.width
            height: 2
            color: rFileSystem.HighlightColor
            opacity: 0.5
        }

        ListView{
            id: processList
            width: parent.width
            height: parent.height - controlBar.height - 2
            model: qtModel.ProcessList
            spacing: 2

            delegate: Rectangle{
                id: processListDelegate
                width: parent.width
                height: 40
                color: "transparent"
                border.color: (processList.currentIndex == index) ? rFileSystem.SelectedColor : "transparent"
                border.width: 1

                Row{
                    anchors.fill: parent
                    anchors.margins: 5
                    spacing: 5
                    Rectangle{
                        id: logoParentRect
                        height: parent.height
                        width: height
                        color: "transparent"
                        Image {
                            id: logo
                            anchors.fill: parent
                            source: "image://xdg/" + model.modelData.PackageName
                            sourceSize.width: width*0.8
                            sourceSize.height: height*0.8
                        }
                    }

                    Column{
                        id: processDataMainLayout
                        width: parent.width - logoParentRect.width
                        height: parent.height

                        Row{
                            width: parent.width
                            height: parent.height - processStatusParentRect.height
                            spacing: 5

                            Rectangle{
                                id: processNameParentRect
                                height: 15
                                width: parent.width - processControlBox.width
                                color: "transparent"
                                Text {
                                    id: processName
                                    text: model.modelData.Title + " (" + model.modelData.AltTitle + ")"
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 12
                                    width: parent.width
                                    height: parent.height
                                }
                            }

                            Row{
                                id: processControlBox
                                width: 75
                                height: 25
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 5

                                RImageButton{
                                    id: resumePauseBtn
                                    width: 25
                                    height: width
                                    icon.source: "/local/assets/process-pause.svg"
                                    hoverText: "Pause"
                                }
                                RImageButton{
                                    id: stopBtn
                                    width: 25
                                    height: width
                                    icon.source: "/local/assets/process-stop.svg"
                                    hoverText: "Stop"
                                }
                            }
                        }

                        Rectangle{
                            id: processStatusParentRect
                            width: parent.width
                            height: 15
                            color: "transparent"
                            Text {
                                id: processStatus
                                text: model.modelData.StatusData
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 10
                                opacity: 0.75
                                width: parent.width
                                height: parent.height
                            }
                        }
                    }
                }
            }
        }
    }
}
