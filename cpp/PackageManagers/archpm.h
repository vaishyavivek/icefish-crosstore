#include "abstractpackagemanager.h"

class ArchPM: public AbstractPackageManager{
    Q_OBJECT

public:
    ArchPM(QObject *parent = nullptr)
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


