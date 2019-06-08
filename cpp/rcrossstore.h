#ifndef RCROSSSTORE_H
#define RCROSSSTORE_H

#include <QObject>
#include <QThread>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>

#include "models/appquerymodel.h"
#include "models/rappdetailsmodel.h"
#include "PackageManagers/archpm.h"
#include "models/notification/notificationmodel.h"


class RCrossStore : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString OsRelease READ OsRelease NOTIFY OsReleaseChanged)

    Q_PROPERTY(AppQueryModel* SearchResultList READ SearchResultList NOTIFY SearchResultListChanged)

    Q_PROPERTY(AppQueryModel* HomeAppList1 READ HomeAppList1 NOTIFY HomeAppList1Changed)
    Q_PROPERTY(AppQueryModel* HomeAppList2 READ HomeAppList2 NOTIFY HomeAppList2Changed)
    Q_PROPERTY(AppQueryModel* HomeAppList3 READ HomeAppList3 NOTIFY HomeAppList3Changed)


    Q_PROPERTY(RAppDetailsModel* CurrentApp READ CurrentApp NOTIFY CurrentAppChanged)

    Q_PROPERTY(QList<QObject*> ProcessList READ ProcessList NOTIFY ProcessListChanged)

    /* Provides error/warning data to NotificationPanel
     * connected with each tab via "Notfiy" slot in the NotificationModel class
     * "Notify" will also cause the N*Panel to show up in global view
     */
    Q_PROPERTY(NotificationModel* NModel READ NModel NOTIFY NModelChanged)

public:
    explicit RCrossStore(QObject *parent = nullptr);

    QString OsRelease() const{ return osRelease;}

    AppQueryModel* SearchResultList() const{ return searchResultList;}

    AppQueryModel* HomeAppList1() const{ return homeAppList1;}
    AppQueryModel* HomeAppList2() const{ return homeAppList2;}
    AppQueryModel* HomeAppList3() const{ return homeAppList3;}

    RAppDetailsModel* CurrentApp() const{ return currentApp;}

    QList<QObject*> ProcessList() const{ return processList;}

    NotificationModel* NModel() const{ return nm;}

signals:
    void OsReleaseChanged();
    void SearchResultListChanged();

    void HomeAppList1Changed();
    void HomeAppList2Changed();
    void HomeAppList3Changed();

    void CurrentAppChanged();
    void ProcessListChanged();

    void NModelChanged();

    void requestToUpdateDatabase();

    void checkInstallationStatusFromPM(QString packageName);

    void requestInstallingPackageFromPM(QString packageName, int index);

    void requestRemovingPackageFromPM(QString packageName, int index);

    void askToSendUpdateRequestFromQml();

public slots:
    void updateDatabase(int agreeCode);

    void generateHomeAppsList();

    //search the app in the database, query can be package name or category
    void searchApp(QString text, QString Category = "", int License = 0);

    //show the details of currently selected app, querying from the previously loaded sqlRecord
    void showAppDetails(int index);
    void showAppDetails(QString packageName);

    //functions to check for installation status of selected candidate
    void checkInstallationStatus(int index);
    void receiveInstallationStatus(InstallationStatus); //updated from thread

    //install the currently selected edition of the app
    void installSelectedCandidate(int index);

    void removeSelectedCandidate(int index);

    void receiveInstallationProgress(QString textUpdate, int index, int progressData); //updated from thread



private:
    QThread pmThread;
    QString osRelease;
    AppQueryModel* searchResultList;
    AppQueryModel *homeAppList1, *homeAppList2, *homeAppList3;

    QSqlDatabase sqlDb;
    QList<QObject*> processList;
    NotificationModel *nm;
    QString cachePath;
    RAppDetailsModel *currentApp;

    ArchPM *archHandle;
};


#endif // RCROSSSTORE_H
