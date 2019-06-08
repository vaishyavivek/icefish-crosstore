#ifndef RAPPDETAILSMODEL_H
#define RAPPDETAILSMODEL_H

#include <QObject>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>

#include "appquerymodel.h"
#include "rappeditions.h"


class RAppDetailsModel: public QObject{
    Q_OBJECT

    Q_PROPERTY(QString PackageName READ PackageName WRITE setPackageName NOTIFY PackageNameChanged)

    Q_PROPERTY(QString InstallButtonText READ InstallButtonText WRITE setInstallButtonText NOTIFY InstallButtonTextChanged)

    Q_PROPERTY(int ExtraAction READ ExtraAction WRITE setExtraAction NOTIFY ExtraActionChanged)

    Q_PROPERTY(QString DisplayName READ DisplayName WRITE setDisplayName NOTIFY DisplayNameChanged)

    Q_PROPERTY(QString SupportURL READ SupportURL WRITE setSupportURL NOTIFY SupportURLChanged)

    Q_PROPERTY(QString Publisher READ Publisher WRITE setPublisher NOTIFY PublisherChanged)

    Q_PROPERTY(QString Description_Short READ Description_Short WRITE setDescription_Short NOTIFY Description_ShortChanged)

    Q_PROPERTY(QString Description_Detail READ Description_Detail WRITE setDescription_Detail NOTIFY Description_DetailChanged)

    Q_PROPERTY(QString Category READ Category WRITE setCategory NOTIFY CategoryChanged)

    Q_PROPERTY(AppQueryModel* Editions READ Editions NOTIFY EditionsChanged)

    Q_PROPERTY(QString License READ License WRITE setLicense NOTIFY LicenseChanged)

public:
    explicit RAppDetailsModel(QObject *parent = nullptr)
        :QObject(parent){
        editions = new AppQueryModel();
        installButtonText = "Please Wait";
        extraAction = 1;
    }

    QString PackageName() const{ return packageName;}
    void setPackageName(const QString PackageName){ packageName = PackageName;}

    QString InstallButtonText() const{ return installButtonText;}
    void setInstallButtonText(const QString InstallButtonText){
        if(installButtonText != InstallButtonText){
            installButtonText = InstallButtonText;
            emit InstallButtonTextChanged();
        }
    }

    int ExtraAction() const{ return extraAction;}
    void setExtraAction(const int ExtraAction){
        if(extraAction != ExtraAction){
            extraAction = ExtraAction;
            emit ExtraActionChanged();
        }
    }

    QString DisplayName() const{ return displayName;}
    void setDisplayName(const QString DisplayName){ displayName = DisplayName;}

    QString SupportURL() const{ return supportURL;}
    void setSupportURL(const QString SupportURL){ supportURL = SupportURL;}

    QString Publisher() const{ return publisher;}
    void setPublisher(const QString Publisher){ publisher = Publisher;}

    QString Description_Short() const{ return description_Short;}
    void setDescription_Short(const QString Description_Short){ description_Short = Description_Short;}

    QString Description_Detail() const{ return description_Detail;}
    void setDescription_Detail(const QString Description_Detail){ description_Detail = Description_Detail;}

    QString Category() const{ return category;}
    void setCategory(const QString Category){ category = Category;}

    AppQueryModel* Editions() const{ return editions;}
    void setEditionsQuery(const QSqlDatabase &sqlDb){
        QString EditionsQuery = "Select * from " + packageName;
        editions->setQuery(EditionsQuery, sqlDb);
    }

    QString License() const{ return license;}
    void setLicense(const QString License){ license = License;}

signals:
    void PackageNameChanged();
    void InstallButtonTextChanged();
    void ExtraActionChanged();
    void DisplayNameChanged();
    void SupportURLChanged();
    void PublisherChanged();
    void Description_ShortChanged();
    void Description_DetailChanged();
    void CategoryChanged();
    void EditionsChanged();
    void LicenseChanged();

private:
    QString packageName;
    QString installButtonText;
    int extraAction;
    QString displayName;
    QString supportURL;
    QString publisher;
    QString description_Short;
    QString description_Detail;
    QString category;
    AppQueryModel* editions;
    QString license;
};

#endif // RAPPDETAILSMODEL_H
