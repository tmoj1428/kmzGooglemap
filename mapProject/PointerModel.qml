import QtQuick 2.7
import QtLocation 5.9

MapItemView {
    model: markerModel
    id: point
    delegate: Component {
        MapQuickItem {
            coordinate: model.position
            sourceItem: PointItem{}
        }
    }
}
