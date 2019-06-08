#ifndef ABSTRACTPACKAGEMANAGER_H
#define ABSTRACTPACKAGEMANAGER_H

#include <QObject>
#include <QProcess>

typedef enum __InstallationStatus{
    ReadyToInstall,
    Installed,
    UpdateAvailable,
    CantBeInstalled
} InstallationStatus;

class AbstractPackageManager: public QObject{
    Q_OBJECT

public:
    explicit AbstractPackageManager(QObject *parent)
        :QObject(parent){
        qRegisterMetaType<InstallationStatus>("InstallationStatus");
    }

signals:
    //provide if the app is installed, need uodate or is not installed
    void provideInstallationStatus(InstallationStatus);

    //provide progress info when an app is currently installing/updating and for removal
    void provideInstallationProgress(QString textUpdate, int index, int progressData);

public slots:
    virtual void updateDatabase() = 0;

    //request if app requires installation or an update is there
    virtual void checkInstallationStatus(QString packageName) = 0;

    //request to install a package
    virtual void installPackageFromOfficialRepo(QString packageName, int index) = 0;

    virtual void installPackageFromExtraRepo(QString packageName, QString link, int index) = 0;

    //request to remove specified package
    virtual void removePackage(QString packageName, int index) = 0;

    virtual void listDependencies(QString packageName) = 0;

    virtual void listReverseDependencies(QString packageName) = 0;

    virtual void performFullSystemUpgrade() = 0;
};

#endif // ABSTRACTPACKAGEMANAGER_H
