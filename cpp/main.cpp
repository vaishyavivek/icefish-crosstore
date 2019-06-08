#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtWebEngine/QtWebEngine>

#include "rfilesystemmodel.h"
#include "rcrossstore.h"
#include "models/xdgiconprovider.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setApplicationName("IceFish CrosStore");
    QCoreApplication::setOrganizationDomain("icefishdevs.com");
    QCoreApplication::setOrganizationName("IceFish Devs");

    QGuiApplication app(argc, argv);
    QtWebEngine::initialize();

    QQmlApplicationEngine *engine = new QQmlApplicationEngine();

    QQmlContext *ctxt = engine->rootContext();

    RFileSystemModel *rfsm = new RFileSystemModel(engine);
    ctxt->setContextProperty("rFileSystem", rfsm);

    RCrossStore *rcs = new RCrossStore(engine);
    ctxt->setContextProperty("qtModel", rcs);

    engine->addImageProvider("xdg", new XDGIconProvider());

    engine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine->rootObjects().isEmpty())
        return -1;

    return app.exec();
}

// #09789e-#7e7d70

/* Goals
 * 1- attach the database (done)
 * 2- display per app data from db using search box (done)
 * 3- add option to install in arch and then in ubuntu via official repos
 * 3a- allow installations out of official repo, AUR, external PPA and git
 * 4- implement hot, trending, latest pages
 * 5- add top 100 apps in linux
 *
 */
