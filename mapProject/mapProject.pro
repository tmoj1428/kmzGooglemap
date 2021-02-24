QT += core gui quickwidgets positioning qml network location xmlpatterns

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    choosemap.cpp \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    choosemap.h \
    mainwindow.h

FORMS += \
    choosemap.ui \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    CenterButton.qml \
    MarkerModel.qml \
    OSmap.qml \
    PointItem.qml \
    PointerModel.qml \
    RoutingModel.qml \
    ZoomSlider.qml \
    googleMap.qml
