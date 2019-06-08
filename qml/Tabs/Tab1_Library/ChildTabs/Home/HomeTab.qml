import QtQuick 2.12

Rectangle {
    id: homeTab
    color: rFileSystem.BackgroundColor2

    Column{
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Rectangle{
            id: adBar
            width: parent.width
            height:250
            Image {
                width: parent.width

                source: "/local/assets/IceFish-Explorer-Poster-2.png"
                sourceSize.height: parent.height
                sourceSize.width: parent.width
            }
        }

        Rectangle{
            id: homeListApp1TitleRect
            width: parent.width
            height: 35
            opacity: 0.5
            gradient: Gradient{
                orientation: Gradient.Horizontal
                GradientStop{ position: 0.0; color: "#49B0F9" }//}//rFileSystem.BackgroundColor1}
                GradientStop{ position: 1.0; color: rFileSystem.BackgroundColor2 }
            }

            Text {
                id: homeListApp1Title
                text: "   Our Recommendations"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 13
                width: parent.width
                height: parent.height
            }
        }

        GridView{
            id: homeListApp1 //contains 5 apps
            width: parent.width
            height: 110
            model: qtModel.HomeAppList1
            cellWidth: 130
            cellHeight: 130
            delegate: Rectangle{
                width: 120
                height: 120
                color: "transparent"
                clip: true

                Column{
                    anchors.fill: parent
                    spacing: 5
                    Image {
                        id: image
                        width: parent.width
                        height: parent.height*0.8 - 5
                        source: "image://xdg/" + model.packageName
                        sourceSize.width: width*0.8
                        sourceSize.height: height*0.8
                    }
                    Text {
                        id: name
                        text: model.friendlyName
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 12
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        width: parent.width
                        height: parent.height*0.2
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    z: -1
                    onEntered: mouseEnteredAnimation.start()
                    onExited: mouseExitedAnimation.start()
                    onClicked: {
                        qtModel.showAppDetails(model.packageName)
                        libraryTabControl.currentIndex = 4
                    }
                }

                Rectangle{
                    id: animatingRect
                    anchors.fill: parent
                    radius: 5
                    opacity: 0.3
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
        }
    }
}
