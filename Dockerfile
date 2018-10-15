# NODE-NEOVIM DEVELOPMENT IN DOCKER 


FROM debian 

# METADATA

LABEL Project="web-dev-env"
LABEL Description="Development environment to work with HTML/CSS/JAVASCRIPT and nodejs as a server"
LABEL Author="Lucas C / llucbrell"


# PROGRAM AND DEPENDENCIES

	# added dev repos for download newest version
RUN echo "deb http://ftp.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "apt-utils"]
RUN ["apt-get", "install", "-y", "python-neovim"]
RUN ["apt-get", "install", "-y", "python3-neovim"]
#RUN ["apt-get", "install", "-y", "python3"]
RUN ["apt-get", "install", "-y", "neovim"]
RUN ["apt-get", "install", "-y", "git"]
RUN ["apt-get", "install", "-y", "tmux"]
RUN ["apt-get", "install", "-y", "gnupg"]
RUN ["apt-get", "install", "-y", "curl"]
RUN ["apt-get", "install", "-y", "wget"]
RUN ["apt-get", "install", "-y", "python-pip","python3-pip"]
RUN ["pip3", "install", "neovim"]
RUN ["pip", "install", "neovim"]
RUN ["pip3", "install", "--upgrade", "neovim"]
RUN ["pip", "install", "--upgrade", "neovim"]
	# download script for node installation 
RUN ["curl", "-o", "./nodeins.sh", "https://deb.nodesource.com/setup_8.x"]
	# change permissions if it's build from windows
RUN ["chmod", "777", "./nodeins.sh"]
	# execute script
RUN ["./nodeins.sh"]
	# install node
RUN ["apt-get", "install", "-y", "nodejs"]
	# install JSHINT and Prettier with npm
RUN ["npm", "install", "-g", "jshint"]
RUN ["npm", "install", "-g", "prettier"]
RUN ["npm", "install", "-g", "neovim"]
RUN ["npm", "install", "-g", "serve"]


# COFIGURATIONS

 #- TMUX UTF-8 configruation
 	# Set variable locales to utf-8 to get spanish keyboard and run tmux
ENV LC_ALL C.UTF-8
	#ENV LANG C.UTF-8
	#ENV LANGUAGE C.UTF-8
	#ENV LC_CTYPE C.UTF-8

 #- NVIM cofiguration
 	# get the vim configuration file
ADD https://raw.githubusercontent.com/llucbrell/vimrc/master/.vimrc /root/.config/nvim/init.vim
#ADD https://raw.githubusercontent.com/Tenn1518/neovim-config/master/init.vim /root/.config/nvim/init.vim
 	# get the vimplug plugin
ADD https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim /root/.local/share/nvim/site/autoload/plug.vim

	# get and set to the apropiated dictionaries for spanish spellchecking
ADD https://github.com/llucbrell/vim-es-spellchecker-rem/blob/master/spanish-spellchecker/es.utf-8.spl?raw=true /root/.local/share/nvim/site/spell/es.utf-8.spl
ADD https://github.com/llucbrell/vim-es-spellchecker-rem/blob/master/spanish-spellchecker/es.utf-8.sug?raw=true /root/.local/share/nvim/site/spell/es.utf-8.sug 
ADD https://github.com/llucbrell/vim-es-spellchecker-rem/blob/master/english-spellchecker/en.utf-8.spl?raw=true /root/.local/share/nvim/site/spell/en.utf-8.spl
ADD https://github.com/llucbrell/vim-es-spellchecker-rem/blob/master/english-spellchecker/en.utf-8.sug?raw=true /root/.local/share/nvim/site/spell/en.utf-8.sug

 	# Install the rest of the plugins with git 
	# create directory for nvim pluggins
RUN ["mkdir", "/root/.local/share/nvim/plugged"]
	# set the bashrc to install the pluggins in background 
RUN echo "alias vim=\"vim +':PlugInstall --sync' +:qa!; vim\"" >> /root/.bashrc 
#RUN echo "alias vim=\"vim +':PlugInstall --silent' \"" >> /root/.bashrc 
 #- WORKING DIRECTORY
 	# create working directory
WORKDIR ["app"]


# PORT ACCESS

EXPOSE 5000 


# INTERACTION
	# execute bash for interactive container
CMD ["tmux"]
