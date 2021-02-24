#include "choosemap.h"
#include "ui_choosemap.h"

chooseMap::chooseMap(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::chooseMap)
{
    ui->setupUi(this);
}

chooseMap::~chooseMap()
{
    delete ui;
}

void chooseMap::on_OSMButton_clicked()
{
    mapType = "OSM";
}

void chooseMap::on_googleMapButton_clicked()
{
    mapType = "google";
}
