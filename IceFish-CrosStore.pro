QT += quick sql webengine
CONFIG += c++11


# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    cpp/PackageManagers/archpm.cpp \
    cpp/PackageManagers/debianpm.cpp \
    cpp/main.cpp \
    cpp/rfilesystemmodel.cpp \
    cpp/rcrossstore.cpp \
    cpp/models/appquerymodel.cpp \
    cpp/models/notification/notificationmodel.cpp
        
        
RESOURCES += qml.qrc \
    iconlibrary.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    cpp/PackageManagers/abstractpackagemanager.h \
    cpp/PackageManagers/archpm.h \
    cpp/rfilesystemmodel.h \
    cpp/rcrossstore.h \
    cpp/models/xdgiconprovider.h \
    cpp/models/appquerymodel.h \
    cpp/models/appdetailmodel.h \
    cpp/models/progressmodel.h \
    cpp/models/rappdetailsmodel.h \
    cpp/models/rappeditions.h \
    cpp/models/notification/notificationmodel.h
