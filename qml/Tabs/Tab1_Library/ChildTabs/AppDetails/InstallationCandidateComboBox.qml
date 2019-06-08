import QtQuick 2.7
import QtQuick.Controls 2.5
import "../../../../CustomComponents"

RComboBox{
    id: installationCandidateComboBox

    delegate: ItemDelegate{
        width: installationCandidateComboBox.width
        contentItem: Text {
            anchors.leftMargin: 2
            text: model.friendlyName
            font: installationCandidateComboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: installationCandidateComboBox.highlightedIndex === index
        onClicked: installationCandidateComboBox.displayText = model.friendlyName
        Component.onCompleted: index == 0 ? installationCandidateComboBox.displayText = model.friendlyName : null
    }

    onCurrentIndexChanged: qtModel.checkInstallationStatus(currentIndex)
}
