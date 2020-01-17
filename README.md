## Docker LAMP Stack

### Installation

1. clone lamp-docker: `git clone git@github.com:HomeCEU/cert_manager_docker.git lamp-docker`
2. change dir: `cd lamp-docker`
3. copy sample.env to .env and make any necessary changes `cp sample.env .env`
4. copy mysql.sample.env to mysql.env and make any necessary changes `cp mysql.sample.env mysql.env`
5. clone your application into app: `git clone <your repository> app`
6. run `docker-compose up`