#ifndef DBLISTMODEL_H
#define DBLISTMODEL_H

#include <QStringListModel>

class ListModel : public QStringListModel
{
    Q_OBJECT

public:

    explicit ListModel(QObject *parent = 0);

    Q_INVOKABLE int indexOf(const QString item);
    Q_INVOKABLE QString get(const int index);
    
signals:
    
public slots:
    
};

#endif // DBLISTMODEL_H
