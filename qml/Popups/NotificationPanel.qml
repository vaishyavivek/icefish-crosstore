/*This file is part of IceFish Explorer.

    IceFish Explorer is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    IceFish Explorer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with IceFish Explorer. If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.7
import QtQuick.Controls 2.2
import "../CustomComponents"

Popup{
    id: notificationPanel
    property int oldY
    property int newY
    modal: false
    padding: 0

    Loader{
        id: notificationPanelParentRect
        anchors.fill: parent

        ErrorMessage{
            id: errorMode
        }

        RequestMessage{
            id: requestMode
        }

        StatusMessage{
            id: statusMode
        }
    }

    enter: Transition{
        NumberAnimation{
            property: "y"
            from: oldY
            to: newY
            duration: 250
            easing.type: Easing.InOutQuad
        }
    }

    exit: Transition{
        NumberAnimation{
            property: "y"
            from: newY
            to: oldY
            duration: 250
            easing.type: Easing.OutInQuad
        }
    }

    Connections{
        target: qtModel.NModel
        ignoreUnknownSignals: true
        onShowNotification: {
            switch(qtModel.NModel.Level){
            case 0:
            case 1:
                notificationPanelParentRect.sourceComponent = errorMode
                break
            case 2:
            case 3:
            case 4:
                notificationPanelParentRect.sourceComponent = statusMode
                break
            case 5:
                notificationPanelParentRect.sourceComponent = requestMode
            }
            notificationPanel.open()
        }
    }
}
