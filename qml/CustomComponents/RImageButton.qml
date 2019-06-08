import QtQuick 2.6
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Button {
    id: rButton
    property string hoverText: ""
    property bool toolTipEnabled: hoverText.length > 0

    hoverEnabled: true
    padding: 0
    icon.color: "transparent"

    contentItem: Rectangle{
        width: rButton.width
        height: rButton.height
        color: "transparent"
        Image{
            id: image
            source: icon.source
            sourceSize.width: parent.width*0.5
            sourceSize.height: parent.height*0.5
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }

        ColorOverlay{
            anchors.fill: image
            source: image
            color: rButton.icon.color
        }
    }

    background: Rectangle {
        id: backgroundRect
        width: rButton.width - 2
        height: rButton.height - 2
        anchors.centerIn: parent
        opacity: enabled ? 1 : 0.4
        color: "transparent"
        radius: 5
    }

    ParallelAnimation{
        id: mouseEnteredAnimation
        PropertyAnimation{
            target: backgroundRect
            property: "color"
            to: rFileSystem.HighlightColor
            duration: rFileSystem.GlobalAnimationDuration
        }
        PropertyAnimation{
            target: backgroundRect
            property: "opacity"
            to: 0.35
            duration: rFileSystem.GlobalAnimationDuration
        }
    }


    ParallelAnimation{
        id: mouseExitedAnimation
        PropertyAnimation{
            target: backgroundRect
            property: "color"
            to: "transparent"
            duration: rFileSystem.GlobalAnimationDuration
        }
        PropertyAnimation{
            target: backgroundRect
            property: "opacity"
            to: 0.25
            duration: rFileSystem.GlobalAnimationDuration
        }
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
            color: rFileSystem.IconColor//rFileSystem.BackgroundColor2
        }
        background: Rectangle {
            radius: tooltip.height/2
            color: rFileSystem.BackgroundColor2//rFileSystem.IconColor
        }
    }

    onHoveredChanged: {
        if(enabled){
            if(hovered)
                mouseEnteredAnimation.start()
            else if(!checked)
                mouseExitedAnimation.start()
        }
    }

    onCheckedChanged: checked ? mouseEnteredAnimation.start() : mouseExitedAnimation.start()

}
