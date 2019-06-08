#include <QCoreApplication>

#include "rfilesystemmodel.h"
//#include <QDBusConnection>
//#include <QDBusConnectionInterface>

RFileSystemModel::RFileSystemModel(QObject *parent)
    : QObject(parent){

    backgroundColor1 = settings.value("global/backgroundColor1").toString();
    backgroundColor2 = settings.value("global/backgroundColor2").toString();
    iconColor = settings.value("global/iconColor").toString();
    animationDuration = settings.value("global/animationDuration").toInt();
    isPinPinned = settings.value("global/isPinPinned").toBool();
}


int RFileSystemModel::AppTheme() const{
    return settings.value("global/appTheme").toInt();
}

void RFileSystemModel::setAppTheme(const int AppTheme){
    settings.setValue("global/appTheme", AppTheme);
}

QString RFileSystemModel::BackgroundColor1() const{
    return backgroundColor1;
}

void RFileSystemModel::setBackgroundColor1(const QString &BackgroundColor1){
    if(backgroundColor1 != BackgroundColor1){
        backgroundColor1 = BackgroundColor1;
        settings.setValue("global/backgroundColor1", BackgroundColor1);
        emit BackgroundColor1Changed();
    }
}

QString RFileSystemModel::BackgroundColor2() const{
    return backgroundColor2;
}

void RFileSystemModel::setBackgroundColor2(const QString &BackgroundColor2){
    if(backgroundColor2 != BackgroundColor2){
        backgroundColor2 = BackgroundColor2;
        settings.setValue("global/backgroundColor2", BackgroundColor2);
        emit BackgroundColor2Changed();
    }
}

QString RFileSystemModel::IconColor() const{
    return iconColor;
}

void RFileSystemModel::setIconColor(const QString &IconColor){
    if(iconColor != IconColor){
        iconColor = IconColor;
        settings.setValue("global/iconColor", iconColor);
        emit IconColorChanged();
    }
}

QString RFileSystemModel::HighlightColor() const{
    return highlightColor;
}

void RFileSystemModel::setHighlightColor(const QString &HighlightColor){
    if(highlightColor != HighlightColor){
        highlightColor = HighlightColor;
        settings.setValue("global/highlightColor", highlightColor);
        emit HighlightColorChanged();
    }
}

QString RFileSystemModel::SelectedColor() const{
    return selectedColor;
}

void RFileSystemModel::setSelectedColor(const QString &SelectedColor){
    if(selectedColor != SelectedColor){
        selectedColor = SelectedColor;
        settings.setValue("global/selectedColor", selectedColor);
        emit SelectedColorChanged();
    }
}




bool RFileSystemModel::IsPinPinned() const{
    return isPinPinned;
}

void RFileSystemModel::setIsPinPinned(const bool IsPinPinned){
    if(IsPinPinned != isPinPinned){
        isPinPinned = IsPinPinned;
        settings.setValue("global/isPinPinned", IsPinPinned);
        emit IsPinPinnedChanged();
    }
}

int RFileSystemModel::GlobalAnimationDuration() const{
    return animationDuration;
}

void RFileSystemModel::setGlobalAnimationDuration(const int GlobalAnimationDuration){
    if(animationDuration != GlobalAnimationDuration){
        animationDuration = GlobalAnimationDuration;
        settings.setValue("global/animationDuration", GlobalAnimationDuration);
        emit GlobalAnimationDurationChanged();
    }
}

RFileSystemModel::~RFileSystemModel(){
    deleteLater();
}

