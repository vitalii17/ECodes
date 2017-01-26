#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString currentdb READ currentdb WRITE setCurrentdb
               NOTIFY currentdbChanged)

public:

    explicit Settings(QObject *parent = 0);
    ~Settings();

    QString currentdb() const;
    void setCurrentdb(const QString arg);
    
signals:

    void currentdbChanged(const QString arg);
    
public slots:

private:

    QSettings *m_pSettings;
    QString m_currentdb;
    
};

#endif // SETTINGS_H
