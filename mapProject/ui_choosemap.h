/********************************************************************************
** Form generated from reading UI file 'choosemap.ui'
**
** Created by: Qt User Interface Compiler version 5.15.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_CHOOSEMAP_H
#define UI_CHOOSEMAP_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QDialogButtonBox>
#include <QtWidgets/QLabel>
#include <QtWidgets/QRadioButton>
#include <QtWidgets/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_chooseMap
{
public:
    QVBoxLayout *verticalLayout_3;
    QLabel *label;
    QRadioButton *OSMButton;
    QRadioButton *googleMapButton;
    QDialogButtonBox *buttonBox;

    void setupUi(QDialog *chooseMap)
    {
        if (chooseMap->objectName().isEmpty())
            chooseMap->setObjectName(QString::fromUtf8("chooseMap"));
        chooseMap->resize(708, 526);
        verticalLayout_3 = new QVBoxLayout(chooseMap);
        verticalLayout_3->setObjectName(QString::fromUtf8("verticalLayout_3"));
        label = new QLabel(chooseMap);
        label->setObjectName(QString::fromUtf8("label"));
        label->setAlignment(Qt::AlignCenter);

        verticalLayout_3->addWidget(label);

        OSMButton = new QRadioButton(chooseMap);
        OSMButton->setObjectName(QString::fromUtf8("OSMButton"));

        verticalLayout_3->addWidget(OSMButton);

        googleMapButton = new QRadioButton(chooseMap);
        googleMapButton->setObjectName(QString::fromUtf8("googleMapButton"));

        verticalLayout_3->addWidget(googleMapButton);

        buttonBox = new QDialogButtonBox(chooseMap);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok);

        verticalLayout_3->addWidget(buttonBox);


        retranslateUi(chooseMap);
        QObject::connect(buttonBox, SIGNAL(rejected()), chooseMap, SLOT(reject()));
        QObject::connect(buttonBox, SIGNAL(accepted()), chooseMap, SLOT(accept()));

        QMetaObject::connectSlotsByName(chooseMap);
    } // setupUi

    void retranslateUi(QDialog *chooseMap)
    {
        chooseMap->setWindowTitle(QCoreApplication::translate("chooseMap", "Dialog", nullptr));
        label->setText(QCoreApplication::translate("chooseMap", "Choose your map:", nullptr));
        OSMButton->setText(QCoreApplication::translate("chooseMap", "Open street map", nullptr));
        googleMapButton->setText(QCoreApplication::translate("chooseMap", "Google Map", nullptr));
    } // retranslateUi

};

namespace Ui {
    class chooseMap: public Ui_chooseMap {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_CHOOSEMAP_H
