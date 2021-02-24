import QtQuick 2.7
import QtLocation 5.9
import QtPositioning 5.9

MapItemView {
    model: routeBetweenPoints
    id: route
    delegate: Component {
        MapRoute {
            route: routeData
            line.color: "red"
            line.width: 10
        }
    }
}
