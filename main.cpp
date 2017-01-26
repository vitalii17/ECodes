#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "sortfilterproxymodel.h"
#include "ecodesmodel.h"
#include "settings.h"
#include "listmodel.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QCoreApplication::setOrganizationName("VS");
    QCoreApplication::setApplicationName("Ecodes");

    // Translation
    QString translationPath = ":/translations/translations/" +
            QLocale::languageToString(QLocale::system().language());

    QTranslator translator;
    translator.load(translationPath);

    app.installTranslator(&translator);
    // End of Translation

    qmlRegisterType<SortFilterProxyModel>("SortFilterProxyModel", 1, 0,
                                          "SortFilterProxyModel");
    qmlRegisterType<EcodesModel>("EcodesModel", 1, 0, "EcodesModel");

    ListModel dbListModel;
    QDir dbDir(":/db/database");
    dbListModel.setStringList(dbDir.entryList());

    ListModel docsListModel;
    QDir docsDir(":/regulations/regulations");
    QStringList docsNameFilters; docsNameFilters << "*.htm";
    docsListModel.setStringList(docsDir.entryList(docsNameFilters));

    Settings settings;

    QDeclarativeView view;
    view.rootContext()->setContextProperty("dbListModel", &dbListModel);
    view.rootContext()->setContextProperty("docsListModel", &docsListModel);
    view.rootContext()->setContextProperty("settings", &settings);
    view.setSource(QUrl("qrc:/gui/qml/main.qml"));
    view.showFullScreen();

    return app.exec();
}

