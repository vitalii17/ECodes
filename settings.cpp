#include "settings.h"

#include <QDebug>

Settings::Settings(QObject *parent) :
    QObject(parent), m_pSettings(new QSettings)
{
    m_currentdb = m_pSettings->value("CurrentDB", "EnglishDB.xml").toString();
}

Settings::~Settings()
{
    if(m_currentdb != m_pSettings->value("CurrentDB", "EnglishDB.xml").toString())
    {
        m_pSettings->setValue("CurrentDB", m_currentdb);
    }

    delete m_pSettings;
}

QString Settings::currentdb() const
{
    return m_currentdb;
}

void Settings::setCurrentdb(const QString arg)
{
    if(m_currentdb != arg)
    {
        m_currentdb = arg;
        emit currentdbChanged(m_currentdb);
    }
}


