#include "archpm.h"
#include <QProcess>
#include <QSettings>
#include <QDateTime>

void ArchPM::updateDatabase(){
    QProcess process;
    process.start("pkexec pacman -Sy");

    process.waitForStarted();

    QByteArray state;
    int errored = true;
    do{
        process.waitForReadyRead();
        state.append(process.readAllStandardOutput());
        if(!state.isEmpty() && errored)
            errored = false;

        QString lastLine = state.mid(state.lastIndexOf("\n", -2), -2);
        emit provideInstallationProgress(lastLine, -1, 0);

    }while(process.state() == QProcess::Running);

    if(!errored){
        process.waitForFinished();
        emit provideInstallationProgress("Database Updated Successfully", -1, 1);
        QSettings settings;
        settings.setValue("internal/lastDbUpdatedOn", QDateTime::currentDateTime());
    }
    else
        emit provideInstallationProgress("An error occured during update", -1, -1);
}

void ArchPM::checkInstallationStatus(QString packageName){
    QProcess process;
    process.start("yay -Qu " + packageName);

    process.waitForStarted();
    process.waitForReadyRead();

    QByteArray result = process.readAllStandardOutput();
    if(result.isEmpty())
        result = process.readAllStandardError();


    /* Possible outcomes of the above command, (doesn't require root)
     * 1. Empty output - nothing to be done, already installed and up to date
     * 2. Contains string "was not found", package is there in the repo but not installed locally
     * 3. Contains string "->", suggesting an update is available
     * 4. If none of above possibility, its an error
    */

    if(result.isEmpty())
        emit provideInstallationStatus(InstallationStatus::Installed);
    else if(result.contains("was not found"))
        emit provideInstallationStatus(InstallationStatus::ReadyToInstall);
    else if(result.contains("->"))
        emit provideInstallationStatus(InstallationStatus::UpdateAvailable);
    else
        emit provideInstallationStatus(InstallationStatus::CantBeInstalled);
}

void ArchPM::installPackageFromOfficialRepo(QString packageName, int index){
    QProcess process;
    //QProcess::execute("bash -c \"yes | pkexec yay -S \"" + packageName);
    process.setEnvironment(QStringList() << "LC_ALL=en_US.UTF-8");
    process.start("bash -c \"yes | pkexec pacman -S \"" + packageName);
    //process.start("pkexec yay -S " + packageName);
    process.waitForStarted();

    QByteArray state;
    int errored = true;
    do{
        process.waitForReadyRead();
        state.append(process.readAllStandardOutput());
        if(!state.isEmpty() && errored)
            errored = false;

        QString lastLine = state.mid(state.lastIndexOf("\n", -2), -2);
        emit provideInstallationProgress(lastLine, index, 0);

    }while(process.state() == QProcess::Running);

    if(!errored){
        process.waitForFinished();
        emit provideInstallationProgress("Installed Successfully", index, 1);
    }
    else
        emit provideInstallationProgress("An error occured during processing", index, -1);
}

void ArchPM::installPackageFromExtraRepo(QString packageName, QString link, int index){

}

void ArchPM::removePackage(QString packageName, int index){
    QProcess process;
    process.setEnvironment(QStringList() << "LC_ALL=en_US.UTF-8");
    process.start("bash -c \"yes | pkexec pacman -Rs \"" + packageName);
    process.waitForStarted();

    QByteArray state;
    int errored = true;
    do{
        process.waitForReadyRead();
        state.append(process.readAllStandardOutput());
        if(!state.isEmpty() && errored)
            errored = false;

        QString lastLine = state.mid(state.lastIndexOf("\n", -2), -2);
        emit provideInstallationProgress(lastLine, index, 0);

    }while(process.state() == QProcess::Running);

    if(!errored){
        process.waitForFinished();
        emit provideInstallationProgress("Removed Successfully", index, 1);
    }
    else
        emit provideInstallationProgress("An error occured during removal", index, -1);
}

void ArchPM::listDependencies(QString packageName){

}

void ArchPM::listReverseDependencies(QString packageName){

}

void ArchPM::performFullSystemUpgrade(){

}
