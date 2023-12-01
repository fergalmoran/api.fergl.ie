#!/usr/bin/env bash

source $HOME/.prv/env

reset_pg() {
  export PGUSER=$PGUSER
  export PGPASSWORD=$PGPASSWORD
  export PGHOST=$PGHOST
  export DBNAME="api.fergl.ie"
  export ASPNETCORE_Environment=Development
  
  echo "Dropping db"
  dropdb -f --if-exists ${DBNAME}
  echo "Creating db"
  createdb ${DBNAME}
}
echo Nuking existing
reset_pg

rm -rf /srv/dev/sites/api.fergl.ie/api.fergl.ie/Data/Migrations/*
#read -p "Press enter to continue"

cd /srv/dev/sites/api.fergl.ie/api.fergl.ie/ || exit

dotnet ef migrations add "Initial" -o Data/Migrations/
dotnet ef database update
