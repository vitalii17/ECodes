#include "listmodel.h"

ListModel::ListModel(QObject *parent) :
    QStringListModel(parent)
{
}

int ListModel::indexOf(const QString item)
{
    return stringList().indexOf(item);
}

QString ListModel::get(const int index)
{
    if((index < 0) && (index > stringList().size() - 1))
    {
        return QString();
    }

    return stringList().at(index);
}
