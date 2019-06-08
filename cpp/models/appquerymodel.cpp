#include "appquerymodel.h"

AppQueryModel::AppQueryModel(QObject *parent)
    :QSqlQueryModel(parent){}


void AppQueryModel::setQuery(const QString &query, const QSqlDatabase &db){
    QSqlQueryModel::setQuery(query, db);
    generateRoleNames();
}

void AppQueryModel::setQuery(const QSqlQuery &query){
    QSqlQueryModel::setQuery(query);
    generateRoleNames();
}

void AppQueryModel::generateRoleNames(){
    m_roleNames.clear();

    for(int i = 0; i < record().count(); i++)
        m_roleNames.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
}


QVariant AppQueryModel::data(const QModelIndex &index, int role) const{

    if(role < Qt::UserRole)
        return QSqlQueryModel::data(index, role);
    else{
        int col = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), col);
        return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
}

