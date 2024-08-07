all: mylogservice logservice.service 
.PHONY: all mylogservice install uninstall 
lib_dir=/usr/local/lib/mylogservice
conf_dir=/usr/local/etc/mylogservice
service_dir=/etc/systemd/system
venv=$(lib_dir)/mylogenv

install: $(service_dir) mylogservice.service
	@echo Installing the service files...
	cp mylogservice.service $(service_dir)
	chown root:root $(service_dir)/mylogservice.service
	chmod 644 $(service_dir)/mylogservice.service

	@echo Installing the library files...
	mkdir -p $(lib_dir)
	cp mylogservice.py $(lib_dir)
	chown root:root $(lib_dir)/*
	chmod 644 $(lib_dir)/*

	@echo Installing the configuration files...
	mkdir -p $(conf_dir)
	cp mylogservice.env $(conf_dir)
	chown root:root $(conf_dir)/*
	chmod 644 $(conf_dir)/*

	@echo Creating python virtual environment and installing packages...
	python3 -m venv $(venv)
	$(venv)/bin/pip3 install -r requirements.txt

	@echo Installation complete...
	@echo run 'systemctl start mylogservice' to start service
	@echo run 'systemctl status mylogservice' to view status

uninstall:
	-systemctl stop mylogservice
	-systemctl disable mylogservice
	@echo Removing library files...
	rm -r $(lib_dir)
	@echo Removing configuration files...
	rm -r $(conf_dir)
	@echo Removing service files...
	rm -r $(service_dir)/mylogservice.service