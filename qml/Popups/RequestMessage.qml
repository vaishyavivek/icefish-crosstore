import QtQuick 2.12
import "../CustomComponents"

Component {
    id: requestMessage

    Column{
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        spacing: 5

        Rectangle{
            width: parent.width
            height: parent.height*0.35
            gradient: Gradient{
                orientation: Gradient.Horizontal
                GradientStop{ position: 0.0; color: rFileSystem.BackgroundColor1}
                GradientStop{ position: 1.0; color: rFileSystem.BackgroundColor2 }
            }

            Text {
                width: parent.width
                height: parent.height
                text: "   " + qtModel.NModel.Header
                font.family: "Sans Serif"
                color: rFileSystem.IconColor
                clip: true
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 12
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.verticalCenter: parent.verticalCenter
            }

            RImageButton{
                id: nmClosebtn
                height: parent.height
                width: height
                anchors.right: parent.right
                icon.source: "/local/assets/close.svg"
                icon.color: rFileSystem.IconColor
                onClicked: notificationPanel.close()
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height*0.65
            color: "transparent"
            Row{
                anchors.fill: parent
                spacing: 5
                Rectangle{
                    width: parent.width - noBtn.width*2 - 10
                    height: parent.height
                    color: "transparent"
                    Text {
                        width: parent.width
                        height: parent.height
                        text: qtModel.NModel.Comment
                        font.family: "Sans Serif"
                        color: rFileSystem.BackgroundColor1
                        clip: true
                        font.pointSize: 12
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                RTextButton{
                    id: yesBtn
                    width: 75
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Okay, Do it"
                    onClicked: qtModel.updateDatabase(1)
                }

                RTextButton{
                    id: noBtn
                    width: 75
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "No, not now"
                    onClicked: notificationPanel.close()
                }
            }
        }
    }
}
