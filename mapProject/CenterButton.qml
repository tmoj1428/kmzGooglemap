import QtQuick 2.7
import QtQuick.Controls 1.4

Button{
    id: lastPoint
    anchors {
        right: parent.right
        top: parent.verticalCenter
        margins: 10
    }
    onClicked: {
        if(pointModel.count > 0){
            map_id.center = pointModel.get(pointNumber).position
            map_id.zoomLevel = 18
        }
    }
}
