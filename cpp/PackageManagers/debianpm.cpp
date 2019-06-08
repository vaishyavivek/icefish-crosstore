#include "abstractpackagemanager.h"

class DebianPM: public AbstractPackageManager{
    Q_OBJECT

public:
    DebianPM(QObject *parent = nullptr)
        :AbstractPackageManager(parent){}

public slots:
    void updateDatabase();
    void checkInstallationStatus(QString packageName);
    void installPackageFromOfficialRepo(QString packageName, int index);
    void installPackageFromExtraRepo(QString packageName, QString link, int index);
    void removePackage(QString packageName, int index);
    void listDependencies(QString packageName);
    void listReverseDependencies(QString packageName);
    void performFullSystemUpgrade();
};


void DebianPM::updateDatabase(){

}

void DebianPM::checkInstallationStatus(QString packageName){

}

void DebianPM::installPackageFromOfficialRepo(QString packageName, int index){

}

void DebianPM::installPackageFromExtraRepo(QString packageName, QString link, int index){

}

void DebianPM::removePackage(QString packageName, int index){

}

void DebianPM::listDependencies(QString packageName){

}

void DebianPM::listReverseDependencies(QString packageName){

}
