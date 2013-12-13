# return the name and public DNS of all running instances
function gbotservers {   
  ec2-describe-instances --filter instance-state-name=running | awk '/INSTANCE/{dns=$4} /TAG/{{name=$5;getline} {print "\033[1;32m" name "\033[0m" " - " dns}}'
}

function gbotservername { 
  ec2-describe-instances -Ftag:Name=$1 | awk '/INSTANCE/{ print $13 }'
}

# return the server name based on the IP as input
function gbotserverip {
  ec2-describe-instances --filter ip-address=$1 | awk '/INSTANCE/{ print $4 }'
}

# ssh into a server using its name ex: gbot-ssh gprod_be1
  # to see a list of all the running servers run gbot-servers
function gbotssh {  
  server="$(ec2-describe-instances -Ftag:Name=$1 | awk '/INSTANCE/ { print $4,$7 }')"
  dns=$(echo $server | awk '{print $1}')
  key=$(echo $server | awk '{print $2}')

  users=('root' 'ec2-user' 'ubuntu')

  for user in $users; do
    ssh -i ~/.pem/$key.pem $user@$dns
    
    if [ $? -eq 1 ]; then
      break
    fi
  done
}