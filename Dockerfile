# NODE-NEOVIM DEVELOPMENT IN DOCKER 


FROM debian 

# METADATA
LABEL Project="node-vim"
LABEL Description="Development environment to work with HTML/CSS/JAVASCRIPT and nodejs as a server"
LABEL Author="Lucas C / llucbrell"

# PROGRAM AND DEPENDENCIES
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "apt-utils"]
RUN ["apt-get", "install", "-y", "neovim"]
RUN ["apt-get", "install", "-y", "git"]
RUN ["apt-get", "install", "-y", "tmux"]
RUN ["apt-get", "install", "-y", "gnupg"]
RUN ["apt-get", "install", "-y", "curl"]
	# download script for node installation 
RUN ["curl", "-o", "./nodeins.sh", "https://deb.nodesource.com/setup_8.x"]
	# change permissions if it's build from windows
RUN ["chmod", "777", "./nodeins.sh"]
	# execute script
RUN ["./nodeins.sh"]
	# install node
RUN ["apt-get", "install", "-y", "nodejs"]


# WORKING DIRECTORY
	# create working directory
WORKDIR ["app"]

# PORT ACCESS
EXPOSE 8338 


# INTERACTION
	# execute bash for interactive container
CMD ["bash"]
