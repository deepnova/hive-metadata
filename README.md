# hive-metastore(hms)
Helm is a package manager for Kubernetes, the project is a helm chart for Hive Metastore. 
The container is lifted from https://github.com/realtimedatalake/hive-metastore-docker.

## DLink - The Real-Time Data Lakehouse 
DLink is the data lakehouse developing by deepexi.com. Hive-metastore is the sub project of DLink.

## Getting started
### Prerequisites
The following prerequisites are required for a successful and properly secured use of Helm.

1. A Kubernetes cluster
2. Deciding what security configurations to apply to your installation, if any
3. Installing and configuring Helm.

Please go to https://helm.sh/docs/intro/quickstart for details.

4. A database, e.g.postgresql or mysql
   
### Create database and user for hms
Create a database for hms, e.g. hms_db.
Create a role/user and grant the read/write/login rights to the role/user, e.g. deep_hms.

There is example sql located in docker/script/create-user-db.postgres.sql, you can ask DBA to perform it.

We can get following values from dba if this step works right:
```
  connectionURL: jdbc:postgresql://host.docker.internal:5432/hms_db
  user: deep_hms
  password: deep_hms
```

### Initialize hive metastore database schema
In this step, we need to setup tables and insert init data for hms. Hms provides commands for that:
```
  schematool -initSchema -dbType postgres
```
Since setuping env to run above command is diffcult, we provide docker-compose.init.yml to make it easy. Please check the file in `docker` folder. Go to docker folder, trigger command:
```
  docker compose -f docker-compose.init.yml up
```
Ensure the command completed with EXITED(0)

### Install hive-metastore chart
Clone this repo and go into the folder. Install helm chart with: 
```
helm install hms-s3 . -f values-hms-example.yaml
```
'hms-s3' is the release name for the hms.
'.' is the filepath of the chart.
### Uninstall
Uninstall the chart by:
```
helm uninstall hms-s3
```

