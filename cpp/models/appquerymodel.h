#ifndef APPQUERYMODEL_H
#define APPQUERYMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>

class AppQueryModel  : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(bool PendingOperation READ PendingOperation WRITE setPendingOperation NOTIFY PendingOperationChanged)

public:
    explicit AppQueryModel(QObject *parent = nullptr);

    bool PendingOperation() const{ return pendingOperation;}
    void setPendingOperation(bool PendingOperation){ pendingOperation = PendingOperation;}

    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    void setQuery(const QSqlQuery &query);

    QVariant data(const QModelIndex &index, int role) const;

    QHash<int, QByteArray> roleNames() const { return m_roleNames;}


signals:
    void PendingOperationChanged();

private:
    bool pendingOperation;
    void generateRoleNames();
    QHash<int, QByteArray> m_roleNames;
};

#endif // APPQUERYMODEL_H
