# get the base image, this one has R, RStudio and pandoc
FROM rocker/verse:3.3.2

# required
MAINTAINER Ben Marwick <benmarwick@gmail.com>

COPY . /researchcompendium
 # go into the repo directory
RUN . /etc/environment \

  # build this compendium package, get deps from MRAN
  # set date here manually
  && R -e "options(repos='https://mran.microsoft.com/snapshot/2017-07-01'); devtools::install('/researchcompendium', dep=TRUE)" \

 # render the manuscript into a docx
  && R -e "rmarkdown::render('/researchcompendium/analysis/paper/paper.Rmd')"




## get the base image, this one has R, RStudio and pandoc
#FROM rocker/verse
#
## required
#MAINTAINER Ben Marwick <benmarwick@gmail.com>
#
## stay current
#RUN apt-get update -y \
#
#  # solve a mysterious & sudden error with XML pkg
#  && apt-get install libxml2-dev -y \
#
#
#  # get the full set of repository files from GitHub
#  && git clone https://github.com/benmarwick/researchcompendium.git \
#  # make these files writable
#  && chmod 777 -R researchcompendium \
#  # go into the repo directory
#  && cd /researchcompendium \
#  # start R and build pkgs that we depend on from
#  # local sources that we have collected with packrat
#  && R -e "0" --args --bootstrap-packrat \
#  # build this compendium package
#  && R -e 'devtools::install(".")' \
#  # render the manuscript into a docx
#  && R -e "rmarkdown::render('analysis/paper/paper.Rmd')"


#################### Notes to self ###############################
# a suitable disposable test env:
# docker run -dp 8787:8787 rocker/rstudio

# to build this image:
# docker build -t benmarwick/researchcompendium https://raw.githubusercontent.com/benmarwick/researchcompendium/master/Dockerfile

# to run this container to work on the project:
# docker run -dp 8787:8787  -v /c/Users/bmarwick/docker:/home/rstudio/ -e ROOT=TRUE  benmarwick/researchcompendium
# then open broswer at localhost:8787 or run `docker-machine ip default` in the shell to find the correct IP address

# go to hub.docker.com
# create empty repo for this repo ('Create Automated Build'), then

# to add CI for the docker image
# add .circle.yml file
# - Pushes new image to hub on successful complete of test
# - And gives a badge to indicate test status
# go to circle-ci to switch on this repo

# On https://circleci.com/gh/benmarwick/this_repo
# I need to set Environment Variables:
# DOCKER_EMAIL
# DOCKER_PASS
# DOCKER_USER

# Circle will push to docker hub automatically after each commit, but
# to manually update the container at the end of a work session:
# docker login # to authenticate with hub
# docker push benmarwick/researchcompendium

# When running this container, the researchcompendium dir is not writable, so we need to
# sudo chmod 777 -R researchcompendium

#

