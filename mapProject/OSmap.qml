import QtQuick 2.7
import QtQuick.Window 2.14
import QtQuick.Controls 1.4
import QtLocation 5.9
import QtPositioning 5.9

Item{
    objectName: "root"
    property var point1: QtPositioning.coordinate();
    property var point2: QtPositioning.coordinate();
    property int pointNumber: 0
    property int distance: 0
    TabView{
        objectName: "tabView"
        anchors.fill: parent
        Tab{
            objectName: "firstTab"
            anchors.fill:parent
            title: "OS maps"    
                Rectangle {
                    visible: true
                    id: mapRectangleID
                    objectName: "mapRect"
                    width: 1024
                    height: 800
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    ListModel {
                        id: markerModel
                        dynamicRoles: true
                    }
                    ListModel {
                        id: pointModel
                        dynamicRoles: true
                    }
                    Map {
                        id: map_id
                        objectName: "map"
                        anchors.fill: parent
                        plugin: Plugin { name: "osm" }
                        center: QtPositioning.coordinate(35.6892,51.3890)
                        zoomLevel: 15
                        PluginParameter {
                            name: "osm.mapping.providersrepository.disabled"
                            value: "true"
                        }
                        PluginParameter {
                            name: "osm.mapping.providersrepository.address"
                            value: "http://maps-redirect.qt.io/osm/5.8"
                        }
                        RouteModel {
                            id: routeBetweenPoints
                            plugin: Plugin { name: "osm" }
                            query: RouteQuery {id: routeQuery }
                        }
                        PointerModel{
                            model: markerModel
                        }
                        MarkerModel{
                            model: pointModel
                        }
                        RoutingModel{
                            model: routeBetweenPoints
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (markerModel.count < 2){
                                    var coordinate = map_id.toCoordinate(Qt.point(mouseX, mouseY))
                                    point1 = coordinate
                                    markerModel.append({"position": coordinate})
                                    routeQuery.addWaypoint(point1)
                                    routeBetweenPoints.update()
                                    if(markerModel.count == 2){
                                        distance = markerModel.get(0).position.distanceTo(markerModel.get(1).position)
                                        map_id.distanceSignal(distance)
                                    }
                                }
                            }
                            onPressAndHold: {
                                markerModel.clear()
                                routeQuery.clearWaypoints()
                                var coordinate = map_id.toCoordinate(Qt.point(mouseX, mouseY))
                                markerModel.append({"position": coordinate})
                                point1 = coordinate
                                routeQuery.addWaypoint(point1)
                                routeBetweenPoints.update()
                            }
                        }

                        function append(newElement) {
                            pointModel.append({"position": QtPositioning.coordinate(newElement.lat, newElement.lon)})
                            pointNumber = pointModel.count - 1
                        }
                        signal distanceSignal(distance: int)
                        CenterButton{
                            iconSource: "./center.png"
                        }
                        ZoomSlider {
                            height: parent.height - 50
                        }
                    }
                }
            }
        }
}
