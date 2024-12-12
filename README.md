# Conda Docker Template

This is a Conda Docker Template.  
The container is bind on specified a local machine user by `.env` file.  
Also, this directory bind mount to volumes.  

## How to use

```sh
git clone $REPO_URL
cd CondaDockerTemplate
cp .env.sample .env
# Specify your environments
vi .env
docker compose build
docker compose up -d
docker compose exec app sh
docker compose down
```
