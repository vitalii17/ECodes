#include "ecodesmodel.h"
#include <QtXml>

#include <QDebug>

EcodesModel::EcodesModel(QObject *parent) : QAbstractListModel(parent)
{
    QHash<int, QByteArray> roles;
    roles[CodeRole]    = "code";
    roles[NameRole]    = "name";
    roles[PurposeRole] = "purpose";
    roles[StatusRole]  = "status";

    setRoleNames(roles);
}

int EcodesModel::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid())
    {
        return 0;
    }

    return m_data.count();
}

QVariant EcodesModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
    {
        return QString();
    }

    if(m_data.at(index.row()).contains(role))
    {
        return m_data.at(index.row())[role];
    }
    else
    {
        return QString();
    }
}

int EcodesModel::count() const
{
    return m_data.count();
}

QUrl EcodesModel::source() const
{
    return m_source;
}

void EcodesModel::setSource(const QUrl arg)
{
    if(m_source != arg)
    {
        m_source = arg;
        emit sourceChanged(m_source);
        parseXml();
    }
}

void EcodesModel::parseXml()
{
    QFile xmlFile(":" + source().path());
    if(xmlFile.fileName().isEmpty())
    {
        return;
    }

    bool openFlag = xmlFile.open(QIODevice::ReadOnly);
    if(!openFlag)
    {
        qDebug() << "Can not open xml file!";
    }

    m_data.clear();

    QXmlStreamReader xmlReader(&xmlFile);

    QXmlStreamReader::TokenType token;
    token = xmlReader.readNext();

    while((token != QXmlStreamReader::EndDocument) && (!xmlReader.hasError()))
    {
        static QString code;
        static QString name;
        static QString purpose;
        static QString status;

        token = xmlReader.readNext();

        if((token == QXmlStreamReader::StartElement) && (xmlReader.name() == "item"))
        {
            while(!((token == QXmlStreamReader::EndElement) && (xmlReader.name() == "item")))
            {
                token = xmlReader.readNext();
                if(token == QXmlStreamReader::Characters)
                {
                    token = xmlReader.readNext();
                    if(xmlReader.name() == "code")
                    {
                        token = xmlReader.readNext();
                        code = xmlReader.text().toString();
                    }
                    if(xmlReader.name() == "name")
                    {
                        token = xmlReader.readNext();
                        name = xmlReader.text().toString();
                    }
                    if(xmlReader.name() == "purpose")
                    {
                        token = xmlReader.readNext();
                        purpose = xmlReader.text().toString();
                    }
                    if(xmlReader.name() == "status")
                    {
                        token = xmlReader.readNext();
                        status = xmlReader.text().toString();
                    }
                }
            }
            QHash<int, QString> data;
            data[CodeRole]    = QString(code);
            data[NameRole]    = QString(name);
            data[PurposeRole] = QString(purpose);
            data[StatusRole]  = QString(status);
            m_data.append(data);
        }
    }

    xmlFile.close();
    emit countChanged(count());
}

