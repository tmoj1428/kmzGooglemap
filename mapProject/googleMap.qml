import QtQuick 2.7
import QtQuick.Window 2.14
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtLocation 5.9
import QtPositioning 5.9
Item {
    objectName: "root"
    property var point1: QtPositioning.coordinate();
    property var point2: QtPositioning.coordinate();
    property int pointNumber: 0
    property int distance: 0
    /*Popup {
        id: popup
        x: 0
        y: 0
        width: 200
        height: parent.height
        ColumnLayout{
            id: pointerLayout
            width: parent.width
            RowLayout{
                id: pointLayout
                width: parent.width
                Layout.fillWidth: true
                Button {
                    iconSource: "./resources/Images/190201-2000-shape_default_4x.png"
                    onClicked: {
                        PointItem.source = "./resources/Images/190201-2000-shape_default_4x.png"
                    }
                }
                Button {
                    iconSource: "./resources/Images/190201-2006-shape_star_4x.png"
                    onClicked: {
                        PointerModel.sourceItem(new Image({width:50, height:50, iconSource:"../resources/Images/190201-2006-shape_star_4x.png"}))
                    }
                }
                Button {
                    iconSource: "./resources/Images/190201-2061-camping-tent_4x.png"
                    onClicked: {
                        PointerModel.sourceItem(new Image({width:50, height:50, iconSource:"../resources/Images/190201-2061-camping-tent_4x.png"}))
                    }
                }
                Button {
                    iconSource: "./resources/Images/190201-2074-checkmark_4x.png"
                    onClicked: {
                        PointerModel.sourceItem = new Image({width:50, height:50, iconSource:"../resources/Images/190201-2074-checkmark_4x.png"})
                    }
                }
                Button {
                    iconSource: "./resources/Images/190201-2130-food-fork-knife_4x.png"
                    onClicked: {
                        PointerModel.sourceItem(new Image({width:50, height:50, iconSource:"../resources/Images/190201-2130-food-fork-knife_4x.png"}))
                    }
                }
            }
        }
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        enter: Transition {
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
        }
        exit: Transition {
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
        }
    }*/
    TabView{
        objectName: "tabView"
        anchors.fill: parent
        Tab{
            objectName: "firstTab"
            anchors.fill:parent
            title: "Google maps"
                Rectangle {
                    visible: true
                    id: mapRectangleID2
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
                        plugin: Plugin { name: "googlemaps" }
                        center: QtPositioning.coordinate(35.6892,51.3890)
                        zoomLevel: 15
                        RouteModel {
                            id: routeBetweenPoints
                            plugin: Plugin { name: "osm" }
                            query: RouteQuery {id: googleRouteQuery }
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
                                    googleRouteQuery.addWaypoint(point1)
                                    routeBetweenPoints.update()
                                    if(markerModel.count == 2){
                                        distance = markerModel.get(0).position.distanceTo(markerModel.get(1).position)
                                        map_id.distanceSignal(distance)
                                    }
                                }
                            }
                            onPressAndHold: {
                                markerModel.clear()
                                googleRouteQuery.clearWaypoints()
                                var coordinate = map_id.toCoordinate(Qt.point(mouseX, mouseY))
                                markerModel.append({"position": coordinate})
                                point1 = coordinate
                                googleRouteQuery.addWaypoint(point1)
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
                        Button {
                            anchors {
                                left: parent.left
                                top: parent.verticalCenter
                                margins: 10
                            }
                            text: "open menu"
                            onClicked: popup.open()
                        }
                        ZoomSlider {
                            height: parent.height - 50
                        }
                    }
                }
            }
    }
}
