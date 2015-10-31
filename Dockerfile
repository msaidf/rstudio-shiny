FROM dceoy/rstudio
MAINTAINER msaidf

apt-get update && apt-get install -y sudo gdebi-core pandoc pandoc-citeproc libcurl4-gnutls-dev libcairo2-dev libxt-dev

wget --no-verbose http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb &&

dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb && rm -f libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && VERSION=$(cat version.txt) && wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/

ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && gdebi -n ss-latest.deb && rm -f version.txt ss-latest.deb

R --no-save -e "install.packages(c('shiny', 'rmarkdown'), repos='http://cran.rstudio.com/')"

cp -R /usr/lib/R/site-library/shiny/examples/* /srv/shiny-server/

EXPOSE 3838
EXPOSE 8787

CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize=0", "--server-app-armor-enabled=0"]
CMD "shiny-server"
