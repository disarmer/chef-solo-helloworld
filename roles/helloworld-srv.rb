name "helloworld-srv"
description "Role for helloworld server"

run_list(
  "recipe[ntp]",
  "recipe[helloworld-app]",
  "recipe[nginx::default]",
  "recipe[database::postgresql]",
  "recipe[postgresql::server]",
  "recipe[unicorn]"
)

default_attributes(
  "postgresql"=>{
    "password"=>{
      "postgres"=>'super#secure'
    },
    pg_hba: [
      { type: 'local', db: 'all', user: 'all', addr: '', method: 'md5' }
    ]
  }
)
