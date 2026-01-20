# Database Connection Strings & Tools

## SQL Server (MSSQL) connection examples

Standard connection string:

```text
Data Source=10.0.0.1;Initial Catalog=MyDatabase;Persist Security Info=True;User ID=admin;Password=MyPassword;
```

SQLCMD connection:

```bash
sqlcmd -S 10.0.0.1 -U admin -P MyPassword
```

## Redis

Install and run Redis locally (Linux):

```bash
sudo apt-get install redis-server
redis-cli -v
sudo service redis-server restart
```

Run Redis via Docker:

```bash
docker run -d -p 6379:6379 --name some-redis redis
```

## RabbitMQ

Run RabbitMQ with Management UI via Docker:

```bash
docker run -d --hostname localhost --name some-rabbit -p 15672:15672 rabbitmq:3-management
# UI available at http://localhost:15672/
```
