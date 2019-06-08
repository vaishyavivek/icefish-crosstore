#ifndef PROGRESSMODEL_H
#define PROGRESSMODEL_H

#include <QObject>

class ProgressModel: public QObject{
    Q_OBJECT
    Q_PROPERTY(QString Title READ Title WRITE setTitle NOTIFY TitleChanged)
    Q_PROPERTY(QString AltTitle READ AltTitle WRITE setAltTitle NOTIFY AltTitleChanged)
    Q_PROPERTY(QString PackageName READ PackageName WRITE setPackageName NOTIFY PackageNameChanged)
    Q_PROPERTY(QString StatusData READ StatusData WRITE setStatusData NOTIFY StatusDataChanged)

    Q_PROPERTY(int CancelProcess READ CancelProcess WRITE setCancelProcess NOTIFY CancelProcessChanged)


public:
    explicit ProgressModel(QObject *parent = nullptr)
        : QObject(parent){}

    QString Title() const{ return title;}
    void setTitle(const QString Title){
        if(title != Title)
            title = Title;
    }

    QString AltTitle() const{ return altTitle;}
    void setAltTitle(const QString AltTitle){
        if(altTitle != AltTitle)
            altTitle = AltTitle;
    }

    QString PackageName() const{ return packageName;}
    void setPackageName(const QString PackageName){
        if(packageName != PackageName)
            packageName = PackageName;
    }

    QString StatusData() const{ return statusData;}
    void setStatusData(const QString StatusData){
        if(statusData != StatusData){
            statusData = StatusData;
            emit StatusDataChanged();
        }
    }

    int CancelProcess() const{ return cancelProcess;}
    void setCancelProcess(const int CancelProcess){
        if(cancelProcess != CancelProcess)
            cancelProcess = CancelProcess;
    }

signals:
    void TitleChanged();
    void AltTitleChanged();
    void PackageNameChanged();
    void StatusDataChanged();
    void CancelProcessChanged();

private:
    QString title;
    QString altTitle;
    QString packageName;
    QString statusData;
    int cancelProcess;
};

#endif // PROGRESSMODEL_H
