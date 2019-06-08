#ifndef RAPPEDITIONS_H
#define RAPPEDITIONS_H

#include <QObject>

class RAppEditions: public QObject{
    Q_OBJECT

    Q_PROPERTY(QString DisplayName READ DisplayName WRITE setDisplayName NOTIFY DisplayNameChanged)

    Q_PROPERTY(QString PackageName READ PackageName WRITE setPackageName NOTIFY PackageNameChanged)

    Q_PROPERTY(QString Source READ Source WRITE setSource NOTIFY SourceChanged)

    Q_PROPERTY(QString InstallCommand READ InstallCommand WRITE setInstallCommand NOTIFY InstallCommandChanged)

    Q_PROPERTY(QString Version READ Version WRITE setVersion NOTIFY VersionChanged)

public:
    explicit RAppEditions(QObject *parent = nullptr)
        :QObject(parent){}

    QString DisplayName() const{ return displayName;}
    void setDisplayName(const QString DisplayName){ displayName = DisplayName;}

    QString PackageName() const{ return packageName;}
    void setPackageName(const QString PackageName){ packageName = PackageName;}

    QString Source() const{ return source;}
    void setSource(const QString Source){ source = Source;}

    QString InstallCommand() const{ return installCommand;}
    void setInstallCommand(const QString InstallCommand){ installCommand = InstallCommand;}

    QString Version() const{ return version;}
    void setVersion(const QString Version){ version = Version;}

signals:
    void DisplayNameChanged();
    void PackageNameChanged();
    void SourceChanged();
    void InstallCommandChanged();
    void VersionChanged();

private:
    QString displayName;
    QString packageName;
    QString source;
    QString installCommand;
    QString version;
};


#endif // RAPPEDITIONS_H
