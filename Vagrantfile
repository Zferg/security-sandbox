# -*- mode: ruby -*-
# vi: set ft=ruby :

$LINUX_TOOLS = <<-EOF

  sudo apt install -y golang-go tldr httpie jq tor 

EOF

Vagrant.configure("2") do |config|
  # Kali Box
  config.vm.define "kali", primary: true do |kali|
  	kali.vm.provider "virtualbox" do |v|
  		v.name = "kali"
		  v.memory = 4096
		  v.cpus = 2
  	end

    # Install kali vagrant box
    kali.vm.box = "kalilinux/rolling"
    kali.vm.hostname = "kali.local"
    
    # Install tools
    kali.vm.provision "shell", type: "shell" do |s|
      s.inline = $LINUX_TOOLS
    end

    # Setup directory structure
    kali.vm.provision "file", source: "data/code", destination: "$HOME/code"
    kali.vm.provision "file", source: "data/ctf", destination: "$HOME/ctf"
    
    kali.trigger.after :up do |trigger|
      trigger.info = "Starting tor"
      trigger.run_remote = { 
        inline: <<-EOF 
          sudo service tor start
        EOF
      }
    end

    kali.vm.post_up_message = "Welcome to Kali Linux by Offensive Security. Enjoy your stay!"
  end
  
  # Security Onion
  config.vm.define "securityonion", autostart: false do |securityonion|
  	securityonion.vm.provider "virtualbox" do |v|
  		v.name = "securityonion"
		v.memory = 4096
		v.cpus = 2
  	end

    securityonion.vm.box = "dlee35/securityonion"
    securityonion.vm.hostname = "securityonion.local"

    # securityonion.vm.provision "shell" do |s|
    #   s.inline = $LINUX_TOOLS
    # end
    
    securityonion.vm.post_up_message = "Welcome to Security Onion by Security Onion Solutions. Bon Appetit!"
  end
  
  # SamuraiWTF
  config.vm.define "samuraiwtf", autostart: false do |samuraiwtf|
    config.vm.box = "SamuraiWTF/samuraiwtf-base_box"
    samuraiwtf.vm.provider "virtualbox" do |v|
      v.name = "samuraiwtf"
      v.memory = 2048
    end
    samuraiwtf.vm.provision "shell", path: ".provision/samuraiwtf.sh"
  end

  # Juiceshop
  config.vm.define "juiceshop", autostart: false do |juiceshop|
  	juiceshop.vm.provider "virtualbox" do |v|
  		v.name = "juiceshop"
		  v.memory = 2048
  	end
  
    juiceshop.vm.box = "ubuntu/xenial64"
    juiceshop.vm.hostname = "juice.sh"
    juiceshop.vm.network "private_network", ip: "192.168.33.20"
    juiceshop.vm.provision "file", source: ".provision/www/default.conf", destination: "/tmp/juice-shop/default.conf"
    juiceshop.vm.provision :shell, path: ".provision/juiceshop.sh"

    juiceshop.vm.post_up_message = "View this machine at http://192.168.33.20"
  end

  # Damn Vulnerable Web App
  config.vm.define "dvwa", autostart: false do |dvwa|
  	dvwa.vm.provider "virtualbox" do |v|
  		v.name = "dvwa"
		  v.memory = 2048
  	end

    dvwa.vm.box = "ubuntu/xenial64"
    dvwa.vm.hostname = "dvwa.local"
    dvwa.vm.network "private_network", ip: "192.168.33.30"
    dvwa.vm.provision "docker" do |d|
      d.run "vulnerables/web-dvwa",
        args: "-p 80:80"
    end

    dvwa.vm.post_up_message = "View this machine at http://192.168.33.30"
  end

  #Metasploitable
  config.vm.define "metasploitable", autostart: false do |metasploitable|
  	metasploitable.vm.provider "virtualbox" do |v|
  		v.name = "metasploitable"
		  v.memory = 4096
  	end
  	
    metasploitable.vm.box = "ubuntu/xenial64"
    metasploitable.vm.hostname = "metasploitable.local"
    metasploitable.vm.network "private_network", ip: "192.168.33.40"
    metasploitable.vm.provision "docker" do |d|
      d.run "vulnerables/metasploit-vulnerability-emulator",
        args: "-P"
    end

    metasploitable.vm.post_up_message = "View this machine at http://192.168.33.40"
  end

  # WebGoat
  config.vm.define "webgoat", autostart: false do |webgoat|
  	webgoat.vm.provider "virtualbox" do |v|
  		v.name = "webgoat"
		  v.memory = 2048
  	end
  	
    webgoat.vm.box = "ubuntu/xenial64"
    webgoat.vm.hostname = "webgoat.local"
    webgoat.vm.network "private_network", ip: "192.168.33.50"
 
    webgoat.vm.provision "docker" do |d|
      d.run "alpine"
    end
    
    webgoat.vm.provision "shell" do |d|
      d.inline = <<-EOF 
        sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        curl https://raw.githubusercontent.com/WebGoat/WebGoat/develop/docker-compose.yml | docker-compose -f - up -d 
      EOF
    end

    webgoat.vm.post_up_message = "View WebGoat at http://192.168.33.50:8080/WebGoat and WebWolf at http://192.168.33.50:9090/WebWolf"
  end


end
