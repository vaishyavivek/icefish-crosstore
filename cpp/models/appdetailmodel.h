#ifndef APPDETAILMODEL_H
#define APPDETAILMODEL_H

#include <QObject>

class AppDetailModel: public QObject{
    Q_OBJECT

    Q_PROPERTY(QString GitPackageName READ GitPackageName NOTIFY GitPackageNameChanged)
    Q_PROPERTY(QString FriendlyName READ FriendlyName NOTIFY FriendlyNameChanged)
    Q_PROPERTY(QString Category READ Category NOTIFY CategoryChanged)
    Q_PROPERTY(QString Description_Short READ Description_Short NOTIFY Description_ShortChanged)
    Q_PROPERTY(QString Description_Detail READ Description_Detail NOTIFY Description_DetailChanged)

public:
    explicit AppDetailModel(QObject *parent = nullptr)
        :QObject (parent){}

    QString GitPackageName() const{ return gitPackageName;}
    QString FriendlyName() const{ return friendlyName;}
    QString Category() const{ return category;}
    QString Description_Short() const{ return description_Short;}
    QString Description_Detail() const{ return description_Detail;}

signals:
    void GitPackageNameChanged();
    void FriendlyNameChanged();
    void CategoryChanged();
    void Description_ShortChanged();
    void Description_DetailChanged();

private:
    QString gitPackageName;
    QString friendlyName;
    QString category;
    QString description_Short;
    QString description_Detail;
};

#endif // APPDETAILMODEL_H
