#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QtQuick>
#include <QQmlContext>
#include <QGeoRoute>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperty>
#include <QMessageBox>
#include "choosemap.h"
#include <QXmlQuery>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    Map();
    QQuickView *view = new QQuickView();
    QWidget *container = QWidget::createWindowContainer(view, this);
    container->setMinimumSize(800, 800);
    container->setFocusPolicy(Qt::TabFocus);
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    if(mapType == "OSM"){
        view->setSource(QUrl("../mapProject/OSmap.qml"));
        object = view->rootObject();
        map = object->findChild<QObject*>("map");
    }else{
        view->setSource(QUrl("../mapProject/googleMap.qml"));
        object = view->rootObject();
        map = object->findChild<QObject*>("map");
    }
    QObject::connect(map, SIGNAL(distanceSignal(int)), this, SLOT(distanceMsgBox(int)));
    ui->gridLayout->addWidget(container);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::Map()
{
    chooseMap chooseMapWindow(this);
    chooseMapWindow.exec();
    mapType = chooseMapWindow.mapType;
}

void MainWindow::on_setPosition_clicked()
{
    QVariantMap newElement;
    double lat = ui->lat->text().toDouble();
    double lon = ui->lon->text().toDouble();
    string posName = ui->positionName->text().toUtf8().constData();;
    QString filename = "Sample";

    std::ofstream handle;

    // http://www.cplusplus.com/reference/ios/ios/exceptions/
    // Throw an exception on failure to open the file or on a write error.
    handle.exceptions(std::ofstream::failbit | std::ofstream::badbit);

    // Open the KML file for writing:
    handle.open("./Sample.kml");

    // Write to the KML file:
    handle << "<?xml version='1.0' encoding='utf-8'?>\n";
    handle << "<kml xmlns='http://www.opengis.net/kml/2.2' xmlns:gx='http://www.google.com/kml/ext/2.2' xmlns:kml='http://www.opengis.net/kml/2.2' xmlns:atom='http://www.w3.org/2005/Atom'>\n";

    handle << kmlPoint(lat, lon, posName);

    handle << "</kml>\n";
    handle.close();
    //testQuery(filename);
    newElement.insert("lat", lat);
    newElement.insert("lon", lon);
    QMetaObject::invokeMethod(map, "append", Q_ARG(QVariant, QVariant::fromValue(newElement)));
}


void MainWindow::distanceMsgBox(const int &distance){
    QMessageBox msgBox;
    msgBox.setText("The distance is about:");
    msgBox.setInformativeText(QString::number(distance) + " meters");
    msgBox.exec();
}

string MainWindow::kmlPoint(double lat1, double lon1, string posName)
{
    ostringstream ss;
        ss << "<Placemark>\n"
           << "<name>"
           << posName
           << "</name>\n"
           << "<description>This is the path between the 2 points</description>\n"
           << "<LookAt>\n"
           << "<longitude>"
           << lon1
           << "</longitude>"
           << "<latitude>"
           << lat1
           << "</latitude>"
           << "</LookAt>"
           << "<Point>"
           << "<coordinates>"
           << lon1 << "," << lat1
           << "</coordinates>"
           << "</Point>"
           << "</Placemark>\n";

        return ss.str();
}

/*
void MainWindow::testQuery(QString &filename)
{
    QFile file("../../Sample.kml");
    file.open(QIODevice::ReadOnly);

    QXmlQuery query;
    query.bindVariable("kmlFile", &file);
    query.setQuery("declare default element namespace \"http://earth.google.com/kml/2.0\"; declare variable $kmlFile external; doc($kmlFile)/kml/Document/Placemark[last()]/GeometryCollection/LineString/coordinates/text()");

    QString result;
    query.evaluateTo(&result);
    qDebug() << result;

    file.close();
}
*/
