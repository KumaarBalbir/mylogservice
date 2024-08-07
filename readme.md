### Custom Linux Service
- A simple python based custom linux service for keep logging the information to a log file whenever there is any resource changes inside a directory.
- To install run `sudo make install` and then enable it by `sudo systemctl enable mylogservice` and then to start the service run `sudo systemctl start mylogservice`
- To uninstall run `sudo make uninstall` and to stop the servie run `sudo systemctl stop mylogservice`
- To check the status of the service, run `sudo systemctl status mylogservice` 
