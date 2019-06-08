#ifndef NOTIFICATIONMODEL_H
#define NOTIFICATIONMODEL_H

#include <QObject>


enum class Message{
    NoInternet = 0,
    PackageManagerFailed,
    DownloadingDB,
    DownloadingPackage,
    InstallingPackage,
    RequestToUpdateDatabase
};

class NotificationModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString Comment READ Comment NOTIFY CommentChanged)
    Q_PROPERTY(QString Header READ Header NOTIFY HeaderChanged)
    Q_PROPERTY(int Level READ Level WRITE setLevel NOTIFY LevelChanged)
    Q_PROPERTY(bool ActivateDnd READ ActivateDnd WRITE setActivateDnd NOTIFY ActivateDndChanged)

public:
    explicit NotificationModel(QObject *parent = nullptr);

    QString Comment() const{ return comment;}
    QString Header() const{ return header;}

    int Level() const{ return level;}
    void setLevel(const int Level);

    bool ActivateDnd() const{ return activateDnd;}
    void setActivateDnd(const bool ActivateDnd){ activateDnd = ActivateDnd;}

signals:
    void CommentChanged();
    void HeaderChanged();
    void LevelChanged();
    void ActivateDndChanged();

    void showNotification();

public slots:
    void Notify(Message, QString Comment = "");

private:
    QString comment, header;
    int level;
    bool activateDnd;
};

#endif // NOTIFICATIONMODEL_H
