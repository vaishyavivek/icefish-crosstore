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
#ifndef RFILESYSTEMMODEL_H
#define RFILESYSTEMMODEL_H

#include <QObject>
#include <QDir>
#include <QThread>
#include <QFile>
#include <QSettings>


class RFileSystemModel : public QObject
{
    Q_OBJECT

    /* Provides index position of AppTheme namely "Light, Dark, ..."
     * 'BackgroundColor' and 'IconColor' are associated with the current theme changed from settings
     * Defaults to Light theme if nothing is found, like started for the first time
     */
    Q_PROPERTY(int AppTheme READ AppTheme WRITE setAppTheme NOTIFY AppThemeChanged)
    Q_PROPERTY(QString BackgroundColor1 READ BackgroundColor1 WRITE setBackgroundColor1 NOTIFY BackgroundColor1Changed)
    Q_PROPERTY(QString BackgroundColor2 READ BackgroundColor2 WRITE setBackgroundColor2 NOTIFY BackgroundColor2Changed)
    Q_PROPERTY(QString IconColor READ IconColor WRITE setIconColor NOTIFY IconColorChanged)
    Q_PROPERTY(QString HighlightColor READ HighlightColor WRITE setHighlightColor NOTIFY HighlightColorChanged)
    Q_PROPERTY(QString SelectedColor READ SelectedColor WRITE setSelectedColor NOTIFY SelectedColorChanged)
    Q_PROPERTY(bool IsPinPinned READ IsPinPinned WRITE setIsPinPinned NOTIFY IsPinPinnedChanged)
    Q_PROPERTY(int GlobalAnimationDuration READ GlobalAnimationDuration WRITE setGlobalAnimationDuration NOTIFY GlobalAnimationDurationChanged)

public:
    explicit RFileSystemModel(QObject *parent = nullptr);

    int AppTheme() const;
    void setAppTheme(const int AppTheme);

    QString BackgroundColor1() const;
    void setBackgroundColor1(const QString &BackgroundColor1);

    QString BackgroundColor2() const;
    void setBackgroundColor2(const QString &BackgroundColor2);

    QString IconColor() const;
    void setIconColor(const QString &IconColor);

    QString HighlightColor() const;
    void setHighlightColor(const QString &HighlightColor);

    QString SelectedColor() const;
    void setSelectedColor(const QString &SelectedColor);

    bool IsPinPinned() const;
    void setIsPinPinned(const bool IsPinPinned);

    int GlobalAnimationDuration() const;
    void setGlobalAnimationDuration(const int GlobalAnimationDuration);

    ~RFileSystemModel();

public slots:

signals:
    void AppThemeChanged();
    void BackgroundColor1Changed();
    void BackgroundColor2Changed();
    void IconColorChanged();
    void HighlightColorChanged();
    void SelectedColorChanged();
    void IsPinPinnedChanged();
    void GlobalAnimationDurationChanged();

private:
    QString backgroundColor1;
    QString backgroundColor2;
    QString iconColor;
    QString highlightColor;
    QString selectedColor;
    bool isPinPinned;
    int animationDuration;

    // Global Settings handler object
    QSettings settings;
};

#endif // RFILESYSTEMMODEL_H
