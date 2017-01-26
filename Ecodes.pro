# Add more folders to ship with the application, here
CONFIG(debug, debug|release) {
    folder_01.source = qml
    DEPLOYMENTFOLDERS += folder_01
}

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian {
    VERSION = 0.1.0

    ICON = Ecodes.svg

    TARGET.UID3 = 0xE03E5DE7
    TARGET = Ecodes
    TARGET.CAPABILITY += NetworkServices

    vendorinfo = \
        "%{\"Vitalii Shunkov\"}" \
        ":\"Vitalii Shunkov\""

    my_deployment.pkg_prerules = vendorinfo
    DEPLOYMENT += my_deployment
    DEPLOYMENT.display_name += E Codes
}

QT += xml

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    sortfilterproxymodel.cpp \
    ecodesmodel.cpp \
    settings.cpp \
    listmodel.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

RESOURCES += \
    resources.qrc

HEADERS += \
    sortfilterproxymodel.h \
    ecodesmodel.h \
    settings.h \
    listmodel.h

OTHER_FILES += \
    qml/DynamicObject.js
