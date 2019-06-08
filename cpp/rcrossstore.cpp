#include "rcrossstore.h"

#include <QDir>
#include <QDebug>
#include <QProcess>
#include <QSettings>
#include <QDateTime>

#include "models/progressmodel.h"

RCrossStore::RCrossStore(QObject *parent) : QObject(parent){
    const QString DRIVER("QSQLITE");
    if(!QSqlDatabase::isDriverAvailable(DRIVER))
        qDebug() << "No Suitable SqLite Driver was found, Aborting now.";



    searchResultList = new AppQueryModel(this);

    cachePath = QDir::homePath() + "/Dropbox";
    QDir::setCurrent(cachePath);

    sqlDb = QSqlDatabase::addDatabase("QSQLITE");
    sqlDb.setDatabaseName("crosstore.db");
    if(!sqlDb.open())
        qDebug() << "Failed to open database file, Aborting now" << sqlDb.lastError().text();

    QFile issueFile("/etc/issue");
    if(issueFile.exists() && issueFile.open(QIODevice::ReadOnly)){
        osRelease = issueFile.readAll();
        if(osRelease.contains("Arch")){
            archHandle = new ArchPM();

            connect(this, &RCrossStore::requestToUpdateDatabase, archHandle, &ArchPM::updateDatabase);

            connect(this, &RCrossStore::checkInstallationStatusFromPM, archHandle, &ArchPM::checkInstallationStatus);
            connect(archHandle, &ArchPM::provideInstallationStatus, this, &RCrossStore::receiveInstallationStatus);

            connect(this, &RCrossStore::requestInstallingPackageFromPM, archHandle, &ArchPM::installPackageFromOfficialRepo);

            connect(this, &RCrossStore::requestRemovingPackageFromPM, archHandle, &ArchPM::removePackage);

            connect(archHandle, &ArchPM::provideInstallationProgress, this, &RCrossStore::receiveInstallationProgress);

            archHandle->moveToThread(&pmThread);
        }
        pmThread.start();
        emit OsReleaseChanged();
    }

    nm = new NotificationModel();
    generateHomeAppsList();
}


void RCrossStore::updateDatabase(int agreeCode){
    if(agreeCode == 2){
        QSettings settings;
        auto thisTime = QDateTime::currentSecsSinceEpoch();
        auto lastUpdateTime = settings.value("internal/lastDbUpdatedOn").toDateTime().toSecsSinceEpoch();
        if(thisTime - lastUpdateTime > 172800) //for 2 days older database
            emit nm->Notify(Message::RequestToUpdateDatabase);
    }
    else if(agreeCode == 1)
        emit requestToUpdateDatabase();
}

void RCrossStore::generateHomeAppsList(){

    int randInt = qrand();

    QString query1 = "SELECT * FROM packageList WHERE";
    query1.append(" friendlyName LIKE '%");
    query1.append((randInt%25 + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 2)%25  + 97));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 5)%25  + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 9)%25  + 97));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 13)%25  + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 17)%25  + 97));
    query1.append("%' LIMIT 5");

    homeAppList1 = new AppQueryModel(this);
    homeAppList1->setQuery(query1, sqlDb);
    emit HomeAppList1Changed();

    QString query2 = "SELECT * FROM packageList WHERE";
    query1.append(" friendlyName LIKE '%");
    query1.append(((randInt + 19)%25 + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 15)%25  + 97));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 23)%25  + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 7)%25  + 97));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 12)%25  + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 13)%25  + 97));
    query1.append("%' LIMIT 10");

    homeAppList2 = new AppQueryModel(this);
    homeAppList2->setQuery(query2, sqlDb);
    emit HomeAppList2Changed();

    QString query3 = "SELECT * FROM packageList WHERE";
    query1.append(" friendlyName LIKE '%");
    query1.append((randInt%25 + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 2)%25  + 97));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 5)%25  + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 9)%25  + 97));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 13)%25  + 65));
    query1.append("%' OR friendlyName LIKE '%");
    query1.append(((randInt + 17)%25  + 97));
    query1.append("%' LIMIT 5");

    homeAppList3 = new AppQueryModel(this);
    homeAppList3->setQuery(query3, sqlDb);
    emit HomeAppList3Changed();
}


void RCrossStore::showAppDetails(QString packageName){
    QSqlQuery query(sqlDb);
    query.exec("SELECT * FROM packageList WHERE packageName = '" + packageName + "'");

    query.next();
    QSqlRecord currentRecord = query.record();

    currentApp = new RAppDetailsModel();
    currentApp->setPackageName(currentRecord.value("packageName").toString());
    currentApp->setDisplayName(currentRecord.value("friendlyName").toString());
    currentApp->setCategory(currentRecord.value("category").toString());
    currentApp->setDescription_Short(currentRecord.value("descriptionShort").toString());
    currentApp->setDescription_Detail(currentRecord.value("descriptionDetailed").toString());
    currentApp->setSupportURL(currentRecord.value("supportUrl").toString());
    currentApp->setPublisher(currentRecord.value("publisher").toString());
    currentApp->setLicense(currentRecord.value("license").toString());
    currentApp->setEditionsQuery(sqlDb);

    emit CurrentAppChanged();
}


void RCrossStore::searchApp(QString text, QString Category, int License){

    QString query = "SELECT * FROM packageList WHERE friendlyName LIKE '%" + text + "%'";

    if(Category.isEmpty() || Category == "All Categories")
        query += " OR category LIKE '%" + text + "%'";
    else
        query += " AND category LIKE '%" + Category + "%'";

    if(License == 1)
        query += " AND license LIKE '%gnu%' OR license LIKE '%mit%'";
    else if(License == 2)
        query += " AND license LIKE '%proprietary%' OR license LIKE '%custom%'";


    searchResultList->setQuery(query, sqlDb);
    emit SearchResultListChanged();
}


void RCrossStore::showAppDetails(int index){
    QSqlRecord currentRecord = searchResultList->record(index);

    currentApp = new RAppDetailsModel();
    currentApp->setPackageName(currentRecord.value("packageName").toString());
    currentApp->setDisplayName(currentRecord.value("friendlyName").toString());
    currentApp->setCategory(currentRecord.value("category").toString());
    currentApp->setDescription_Short(currentRecord.value("descriptionShort").toString());
    currentApp->setDescription_Detail(currentRecord.value("descriptionDetailed").toString());
    currentApp->setSupportURL(currentRecord.value("supportUrl").toString());
    currentApp->setPublisher(currentRecord.value("publisher").toString());
    currentApp->setLicense(currentRecord.value("license").toString());
    currentApp->setEditionsQuery(sqlDb);

    emit CurrentAppChanged();
}



void RCrossStore::checkInstallationStatus(int index){
    auto appInfo = qobject_cast<AppQueryModel*>(currentApp->Editions());
    auto record = appInfo->record(index);
    if(osRelease.contains("Arch") && !appInfo->PendingOperation()){
        QString packageName = record.value("archPackageName").toString();
        //QString pmType = record.value("archSource").toString();
        //if(pmType.contains("Pacman") || pmType.contains("AUR"))
        emit checkInstallationStatusFromPM(packageName);
        currentApp->setInstallButtonText("Fetching");
        currentApp->setExtraAction(1);
    }
}

void RCrossStore::receiveInstallationStatus(InstallationStatus status){
    if(status == InstallationStatus::Installed){
        currentApp->setInstallButtonText("Repair");
        currentApp->setExtraAction(0);
    }
    else if(status == InstallationStatus::ReadyToInstall)
        currentApp->setInstallButtonText("Install");
    else if(status == InstallationStatus::UpdateAvailable)
        currentApp->setInstallButtonText("Update");
    else{
        currentApp->setInstallButtonText("Error");
        currentApp->setExtraAction(1);
    }
}



void RCrossStore::installSelectedCandidate(int index){
    auto appInfo = qobject_cast<AppQueryModel*>(currentApp->Editions());
    appInfo->setPendingOperation(true);

    if(osRelease.contains("Arch")){
        auto record = appInfo->record(index);
        QString packageName = record.value("archPackageName").toString();
        QString editionName = record.value("friendlyName").toString();

        ProgressModel *pm = new ProgressModel();
        pm->setTitle(currentApp->DisplayName());
        pm->setAltTitle(editionName);
        pm->setPackageName(currentApp->PackageName());
        pm->setStatusData("Initializing Transaction...");
        processList.append(pm);
        emit ProcessListChanged();

        emit requestInstallingPackageFromPM(packageName, processList.length() - 1);
        currentApp->setInstallButtonText("Installing");
        currentApp->setExtraAction(0);
    }
    nm->setActivateDnd(false);
}

void RCrossStore::removeSelectedCandidate(int index){
    auto appInfo = qobject_cast<AppQueryModel*>(currentApp->Editions());
    appInfo->setPendingOperation(true);

    QString packageName, editionName;

    if(osRelease.contains("Arch")){
        auto record = appInfo->record(index);
        packageName = record.value("archPackageName").toString();
        editionName = record.value("friendlyName").toString();
    }

    ProgressModel *pm = new ProgressModel();
    pm->setTitle(currentApp->DisplayName());
    pm->setAltTitle(editionName);
    pm->setPackageName(currentApp->PackageName());
    pm->setStatusData("Initializing Transaction...");
    processList.append(pm);
    emit ProcessListChanged();

    emit requestRemovingPackageFromPM(packageName, processList.length() - 1);
    currentApp->setInstallButtonText("Removing");
    currentApp->setExtraAction(0);

    nm->setActivateDnd(false);
}

void RCrossStore::receiveInstallationProgress(QString textUpdate, int index, int progressData){
    if(index >= 0){
        auto pm = qobject_cast<ProgressModel*>(processList.at(index));
        pm->setStatusData(textUpdate);

        if(progressData == 1)
            emit askToSendUpdateRequestFromQml();
    }

    if(!nm->ActivateDnd()){
        if(textUpdate.contains("downloading", Qt::CaseInsensitive))
            nm->Notify(Message::DownloadingPackage, textUpdate);
        else
            nm->Notify(Message::InstallingPackage, textUpdate);
    }
}
