#ifndef CHOOSEMAP_H
#define CHOOSEMAP_H

#include <QDialog>

namespace Ui {
class chooseMap;
}

class chooseMap : public QDialog
{
    Q_OBJECT

public:
    explicit chooseMap(QWidget *parent = nullptr);
    ~chooseMap();
    QString mapType;

private slots:
    void on_OSMButton_clicked();

    void on_googleMapButton_clicked();

private:
    Ui::chooseMap *ui;
};

#endif // CHOOSEMAP_H
