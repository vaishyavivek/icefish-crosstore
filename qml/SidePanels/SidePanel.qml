import QtQuick 2.12
import QtQuick.Controls 2.2
import "../CustomComponents"

Popup {
    id: sidePanel
    property bool isExpanded: false
    property bool isPined: rFileSystem.IsPinPinned
    property int normalizedWidth: 35
    property int widthWhenExpanded: 200

    padding: 0
    width: parent.width
    height: parent.height
    closePolicy: Popup.NoAutoClose

    Rectangle{
        id: sidePanelParentRect
        width: parent.width
        height: parent.height
        color: rFileSystem.BackgroundColor1
        /*gradient: Gradient{
            orientation: Gradient.Horizontal
            GradientStop{ position: 0.0; color: "#49B0F9"}//rFileSystem.BackgroundColor1}
            GradientStop{ position: 1.0; color: rFileSystem.BackgroundColor2 }
        }*/

        Column{
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.topMargin: 10
            spacing: 2
            Rectangle{
                id: controlBar
                width: parent.width
                height: normalizedWidth
                color: "transparent"

                RImageButton{
                    id: hamburgerBtn
                    width: normalizedWidth
                    height: normalizedWidth
                    icon.source: "/local/assets/menu.svg"
                    icon.color: rFileSystem.IconColor
                    onClicked: (!isPined && isExpanded) ? reverseExpandMenu() : expandMenu()
                }

                RImageButton{
                    id: pinBtn
                    width: normalizedWidth*0.5
                    height: width
                    visible: isExpanded
                    anchors.right: parent.right
                    icon.source: isPined ? "/local/assets/pin.png" : "/local/assets/unpin.svg"
                    icon.color: rFileSystem.IconColor
                    onClicked: rFileSystem.IsPinPinned = !isPined
                }
            }

            Flickable{
                width: parent.width
                height: parent.height
                contentWidth: parent.width
                contentHeight: (rFileSystem.DiskDataListCount + 14)*normalizedWidth

                Column{
                    anchors.fill: parent
                    spacing: 2

                    ButtonGroup{id: radioGroup}

                    RImageExpandingButton{
                        id: libraryBtn
                        width: parent.width
                        height: normalizedWidth
                        icon.source: "image://xdg/package-x-generic"
                        text: "Library"
                        hoverText: "Browse the Collection"
                        ButtonGroup.group: radioGroup
                        checked: true
                        onClicked: mainTabControl.currentIndex = 0
                    }

                    RImageExpandingButton{
                        id: appsBtn
                        width: parent.width
                        height: normalizedWidth
                        icon.source: "image://xdg/user-library"
                        text: "Your Apps"
                        hoverText: "Know what you already have"
                        ButtonGroup.group: radioGroup
                        onClicked: mainTabControl.currentIndex = 1
                    }

                    RImageExpandingButton{
                        id: settingsBtn
                        width: parent.width
                        height: normalizedWidth
                        icon.source: "/local/assets/settings.svg"
                        icon.color: rFileSystem.IconColor
                        text: "Global Settings"
                        hoverText: "Customize your Store Experience"
                        ButtonGroup.group: radioGroup
                        checked: settingsPanel.isOpened

                        SettingsPanel{
                            id: settingsPanel
                            x: sidePanel.width
                            y: sidePanelParentRect.y - settingsBtn.y - 2
                            widthWhenExpanded: mainWindow.width*0.35
                            height: mainWindow.height - 35
                        }
                        onClicked: {
                            settingsPanel.isOpened ? settingsPanel.close() : settingsPanel.open()
                            settingsPanel.isOpened = !settingsPanel.isOpened
                        }
                    }

                }
            }
        }
    }

    PropertyAnimation{
        id: expandAnimation
        target: sidePanel
        property: "width"
        to: widthWhenExpanded
        duration: rFileSystem.GlobalAnimationDuration*2
    }

    PropertyAnimation{
        id: reverseExpandAnimation
        target: sidePanel
        property: "width"
        to: normalizedWidth + 10
        duration: rFileSystem.GlobalAnimationDuration*2
    }

    Component.onCompleted: sidePanel.open()

    function expandMenu(){
        if(!isExpanded){
            isExpanded = true
            expandAnimation.start()
        }
        if(isPined)
            sideBar.width = widthWhenExpanded
    }

    function reverseExpandMenu(){
        if(isExpanded){
            isExpanded = false
            reverseExpandAnimation.start()
            sideBar.width = normalizedWidth + 10
        }
    }

    onIsPinedChanged: {
        widthWhenExpanded = 200
        isPined ? expandMenu() : reverseExpandMenu()
    }
}
