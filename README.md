# Python Flask To-Do App

A small Flask + SQLite task manager for practising Docker and AWS ECR/EC2 deployment.

## Project structure

```text
python-todo-app/
├── app.py
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
└── templates/
    └── index.html
```

## Run locally without Docker

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python app.py
```

Open http://localhost:5000.

## Run with Docker

```powershell
docker build -t python-todo-app:v1 .
docker run -d --name todo-container -p 5000:5000 -v todo-data:/app/data -e DATABASE=/app/data/todo.db python-todo-app:v1
```

Or use Docker Compose:

```powershell
docker compose up --build -d
docker compose ps
docker compose logs -f
```

Open http://localhost:5000.

Stop the Compose application:

```powershell
docker compose down
```

The named Docker volume `todo-data` keeps the SQLite database when the container is recreated. To delete the database too, run `docker compose down -v`.

## Useful checks

- App: http://localhost:5000
- Health endpoint: http://localhost:5000/health
- Container logs: `docker logs todo-container`
- Stop standalone container: `docker stop todo-container`
- Remove standalone container: `docker rm todo-container`

## AWS practice

1. Create a private ECR repository named `python-todo-app`.
2. Build and tag the image for your ECR repository.
3. Push it to ECR.
4. Launch an EC2 instance and attach an IAM role with `AmazonEC2ContainerRegistryReadOnly`.
5. Install Docker and AWS CLI on EC2.
6. Log in to ECR, pull the image, and run it with port `5000` mapped.
7. Allow inbound TCP 5000 only from your own IP while practising.

For real deployments, do not expose Flask's development server directly to the internet. Use a production WSGI server such as Gunicorn behind a reverse proxy and HTTPS.

AWS resources can incur charges. Check current pricing and your account's Free Tier eligibility, and remove resources after practice.
