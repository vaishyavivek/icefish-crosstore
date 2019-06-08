import QtQuick 2.6
import QtQuick.Controls 2.1

Button {
    id: rTextButton
    property string hoverText: ""
    property bool toolTipEnabled: hoverText.length > 0

    hoverEnabled: true
    padding: 0

    contentItem: Item{
        width: rTextButton.width
        height: rTextButton.height

        Text {
            width: parent.width
            height: parent.height
            text: rTextButton.text
            color: rFileSystem.IconColor
            font.family: "Sans Serif"
            font.pointSize: 12
            clip: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    background: Rectangle {
        id: backgroundRect
        width: rTextButton.width - 2
        height: rTextButton.height - 2
        anchors.centerIn: parent
        opacity: enabled ? 1 : 0.75
        radius: 5
        color: rFileSystem.HighlightColor
    }


    PropertyAnimation{
        id: mouseEnteredAnimation
        target: backgroundRect
        property: "opacity"
        to: 0.5
        duration: rFileSystem.GlobalAnimationDuration
    }


    PropertyAnimation{
        id: mouseExitedAnimation
        target: backgroundRect
        property: "opacity"
        to: 0.75
        duration: rFileSystem.GlobalAnimationDuration
    }


    ToolTip{
        id: tooltip
        visible: toolTipEnabled && parent.hovered
        text: hoverText
        delay: 500
        timeout: 1000
        contentItem: Text {
            text: tooltip.text
            font: tooltip.font
            color: rFileSystem.BackgroundColor2
        }
        background: Rectangle {
            color: rFileSystem.IconColor
        }
    }

    onHoveredChanged: {
        if(hovered)
            mouseEnteredAnimation.start()
        else if(!checked)
            mouseExitedAnimation.start()
    }

    onCheckedChanged: checked ? mouseEnteredAnimation.start() : mouseExitedAnimation.start()

}
