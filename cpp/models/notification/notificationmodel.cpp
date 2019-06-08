/*This file is part of IceFish Explorer.

    IceFish Explorer is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    IceFish Explorer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with IceFish Explorer. If not, see <http://www.gnu.org/licenses/>.
*/
#include "notificationmodel.h"

NotificationModel::NotificationModel(QObject *parent)
    : QObject(parent){
}

void NotificationModel::Notify(Message code, QString Comment){
    if(code == Message::NoInternet){
        header = "No Internet Connection";
        comment = "Make sure you're connected to a working network.";
    }
    else if(code == Message::PackageManagerFailed){
        header = "Backend Died";
        comment = "The Package Manager could not fulfil your request.";
    }
    else if(code == Message::DownloadingDB){
        header = "Updating Package Database from Official sources";
        comment = Comment;
    }
    else if(code == Message::DownloadingPackage){
        header = "Downloading Package, Please hang on...";
        comment = Comment;
    }
    else if(code == Message::InstallingPackage){
        header = "Installing Package, Please hang on...";
        comment = Comment;
    }
    else if(code == Message::RequestToUpdateDatabase){
        header = "Reminder to update Database";
        comment = "Current Database entries seem to be old, would you like to update them?";
    }

    emit HeaderChanged();
    emit CommentChanged();
    level = static_cast<int>(code);
    emit showNotification();
}

void NotificationModel::setLevel(const int Level){
    level = Level;
    if(level == 0)
        Notify(Message::NoInternet);
}
