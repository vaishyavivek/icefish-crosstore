import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtWebKit 3.0
import "../../../../CustomComponents"

Rectangle{
    width: appDetailsPageTabView.width
    height: appDetailsPageTabView.height
    color: rFileSystem.BackgroundColor2

    WebView{
        id: webview
        width: parent.width
        height: parent.height*0.5
        url: qtModel.CurrentApp.SupportURL

        BusyIndicator{
            anchors.centerIn: parent
            running: webview.loading
        }

        onLoadingChanged: {
            if(loadRequest.status === WebView.LoadFailedStatus){
                rFileSystem.NModel.Level = 0
            }
        }
    }

    Rectangle{
        y: parent.y + parent.height*0.4
        width: parent.width*0.9
        height: parent.height*0.6
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter

        Row{
            anchors.fill: parent
            spacing: 10
            Rectangle{
                id: ratingAndLogo
                height: parent.height
                width: parent.width*0.3
                color: "transparent"
                Column{
                    anchors.fill: parent
                    spacing: 8
                    Image {
                        id: logo
                        width: parent.width
                        height: width
                        source: "image://xdg/" + qtModel.CurrentApp.PackageName
                        anchors.horizontalCenter: parent.horizontalCenter
                        sourceSize.width: width*0.8
                        sourceSize.height: width*0.8
                    }

                    Rectangle{
                        id: ratingStars
                        width: parent.width*0.8 + 8
                        height: width/5
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter

                        ListView{
                            id: ratingStarsListview
                            height: parent.height
                            width: 5*height
                            spacing: 2
                            orientation: ListView.Horizontal
                            anchors.horizontalCenter: parent.horizontalCenter
                            model: 5
                            delegate: Rectangle{
                                height: parent.height
                                width: height
                                color: "transparent"
                                Image {
                                    source: "/local/assets/rating-star.svg"
                                    sourceSize.width: parent.width*0.75
                                    sourceSize.height: parent.height*0.75
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }

                    Rectangle{
                        id: basedOnText
                        width: parent.width
                        height: 25
                        color: "transparent"
                        Text {
                            anchors.fill: parent
                            text: qsTr("Based on N Ratings\nand M Reviews")
                            font.pointSize: 9
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    RImageButton{
                        id: sendReviewBtn
                        width: 35
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        icon.source: "/local/assets/rate-app.svg"
                        hoverText: "Review " + qtModel.CurrentApp.DisplayName + " now"
                    }
                }
            }

            Rectangle{
                height: parent.height
                width: parent.width*0.7
                color: "transparent"

                Column{
                    anchors.fill: parent
                    spacing: 5

                    Rectangle{
                        width: parent.width
                        height: appDetailsPageTabView.height*0.12
                        color: "transparent"
                    }

                    Rectangle{
                        width: parent.width
                        height: 15
                        color: "transparent"
                        Text {
                            id: name
                            text: qtModel.CurrentApp.DisplayName
                            font.bold: true
                            font.pointSize: 15
                            verticalAlignment: Text.AlignVCenter
                            width: parent.width
                            height: parent.height
                        }
                    }

                    Rectangle{
                        width: parent.width
                        height: 15
                        color: "transparent"
                        Text {
                            id: publisher
                            text: '<html><a href="' + qtModel.CurrentApp.SupportURL + '">' +
                                  qtModel.CurrentApp.Publisher + '</a></html>'
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 11
                            width: parent.width
                            height: parent.height
                            onLinkActivated: Qt.openUrlExternally(link)
                        }
                    }

                    Rectangle{
                        width: parent.width
                        height: 25
                        color: "transparent"
                        Text {
                            id: description_short
                            text: qtModel.CurrentApp.Description_Short
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 11
                            width: parent.width
                            height: parent.height
                        }
                    }

                    Rectangle{
                        width: parent.width
                        height: 100
                        color: "transparent"
                        Column{
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10
                            Text{
                                id: description_detailed
                                text: qtModel.CurrentApp.Description_Detail
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 10
                                width: parent.width
                                height: parent.height*0.8
                                clip: true
                            }

                            Text {
                                text: "Read More"
                                width: parent.width
                                height: parent.height*0.2 - 30
                                color: "navy"
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: showDetailedDescriptionTooltip.open()
                                }
                            }
                        }




                    }

                    Row{
                        id: installationBar
                        width: parent.width
                        height: 30
                        spacing: 10

                        InstallationCandidateComboBox{
                            id: installationCandidateList
                            width: 200
                            height: parent.height
                            model: qtModel.CurrentApp.Editions

                            Connections{
                                target: qtModel
                                onAskToSendUpdateRequestFromQml: qtModel.checkInstallationStatus(installationCandidateList.currentIndex)
                            }
                        }


                        RTextButton{
                            id: installBtn
                            width: 100
                            height: parent.height
                            text: qtModel.CurrentApp.InstallButtonText
                            enabled: text !== "Fetching"
                            onClicked: {
                                qtModel.installSelectedCandidate(installationCandidateList.currentIndex)
                                qtModel.CurrentApp.ExtraAction = 1
                            }
                        }

                        Rectangle{
                            id: extraBtn
                            width: 100
                            height: parent.height
                            color: "transparent"
                            visible: (qtModel.CurrentApp.ExtraAction === 0)

                            Text {
                                id: extraBtnText
                                anchors.fill: parent
                                text: "Uninstall"
                                font.underline: true
                                font.pointSize: 9
                                verticalAlignment: Text.AlignVCenter
                                color: rFileSystem.HighlightColor
                            }

                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: extraBtnText.color = rFileSystem.SelectedColor
                                onExited: extraBtnText.color = rFileSystem.HighlightColor
                                onClicked: {
                                    qtModel.removeSelectedCandidate(installationCandidateList.currentIndex)
                                    qtModel.CurrentApp.ExtraAction = 1
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    ToolTip{
        id: showDetailedDescriptionTooltip
        width: parent.width*0.75
        height: parent.height*0.75
        anchors.centerIn: parent

        contentItem: Text {
            text: qtModel.CurrentApp.Description_Detail
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            width: parent.width
            height: parent.height
        }

        //background: rFileSystem.BackgroundColor2
    }

}
