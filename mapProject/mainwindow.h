#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
    QObject *object;
    QObject *map;
    QString mapType;

private slots:

    void on_setPosition_clicked();

    void distanceMsgBox(const int &distance);

    void Map();

    std::string kmlPoint(double lat1, double lon1, std::string posName);

    //void testQuery(QString &filename);
private:
    Ui::MainWindow *ui;
};
#endif // MAINWINDOW_H
