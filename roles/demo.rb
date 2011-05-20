name 'demo-drupal'
description 'Drupal demo chef role'
default_attributes(
  "placeholders" => {
    "{{demo_db_username}}" => "root",
    "{{demo_db_password}}" => "",
    "{{demo_db_host}}" => "localhost",
  },
  
  "drupal" => {
    "demo-drupal" => {
      "home" => "/opt/drupal",
      "cron" => "1",
      "sites" => {
        "default" => {
          "db_url" => "mysqli://{{demo_db_username}}:{{demo_db_password}}@{{demo_db_host}}/{{demo_map_db_name}}"
        }
      }
    }
  },
  
  "magento" => {
    "demo-magento" => {
      "home" => "/opt/magento",
      "cron" => "1",
      "local" => {
        "global" => {          
          "disable_local_modules" => "false",
          "install" => {
            "date" => "Thu, 1 Nov 2010 15:08:59 +0000"
          },
          
          "crypt" => {
            "key" => "123456185798WaFSQped746f6d0cs96"
          },
          
          "resources" => {
            "db" => {
              "table_prefix" => ""
            },
            
            "default_setup" => {
              "connection" => {
                "host" => "{{sample_db_host}}",
                "username" => "{{sample_db_username}}",
                "password" => "{{sample_db_password}}",
                "dbname" => "{{sample_magento_db_name}}",
                "active" => "1"
              }
            }
          }
        }
      }
    }
  }
)