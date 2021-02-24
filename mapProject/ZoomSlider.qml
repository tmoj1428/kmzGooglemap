import QtQuick 2.0
import QtQuick.Controls 1.4

Slider{
    id: zoomSlider
    anchors {
        left: parent.left
        leftMargin: 20
        topMargin: 50
        bottomMargin: 0
    }
//    height: parent.height - 50
    value: map_id.zoomLevel
    maximumValue: 22.0
    stepSize: 0.1
    minimumValue: 8.0
    orientation: Qt.Vertical
    onPressedChanged: {
        map_id.zoomLevel = zoomSlider.value
    }
}
