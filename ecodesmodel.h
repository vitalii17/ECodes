#ifndef ECODESMODEL_H
#define ECODESMODEL_H

#include <QAbstractListModel>
#include <QStringList>
#include <QUrl>

class EcodesModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)

public:

    enum Roles
    {
        CodeRole = Qt::UserRole + 1,
        NameRole,
        PurposeRole,
        StatusRole
    };

    EcodesModel(QObject *parent = 0);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    int count() const;

    QUrl source() const;
    void setSource(const QUrl arg);

private:

    void parseXml();

signals:

    void countChanged(int value);
    void sourceChanged(const QUrl source);

private:

    QList< QHash<int, QString> > m_data;
    QUrl m_source;

};

#endif // ECODESMODEL_H
