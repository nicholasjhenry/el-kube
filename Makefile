deps.run:
	docker-compose up -d

app.start.node_a:
	iex --name a@127.0.0.1 -S mix phx.server

app.start.node_b:
	HTTP_PORT=4001 iex --name b@127.0.0.1 -S mix phx.server

app.smoke_test.phx:
	DB_URL=ecto://postgres:postgres@localhost/el_kube_dev \
	RELEASE_COOKIE=foo \
	SECRET_KEY_BASE=foo \
	HOSTNAME=127.0.0.1 \
	SERVICE_NAME=localhost.svc \
	APP_HOST=localhost \
	PORT=4000 \
	_build/prod/rel/el_kube/bin/el_kube start

# ElKube.Repo.query("select 1 as test")
app.smoke_test.console:
	DB_URL=ecto://postgres:postgres@localhost/el_kube_dev \
	RELEASE_COOKIE=foo \
	SECRET_KEY_BASE=foo \
	HOSTNAME=127.0.0.1 \
	SERVICE_NAME=localhost.svc \
	APP_HOST=localhost \
	PORT=4000 \
	_build/prod/rel/el_kube/bin/el_kube remote

container.build:
	docker build -t el_kube:latest .

container.run:
	docker run -it -d --rm \
	-e DB_URL=ecto://postgres:postgres@db/el_kube_prod \
	-e RELEASE_COOKIE=secret-cookie \
	-e SECRET_KEY_BASE=your-secret-key \
	-e SERVICE_NAME=el-kube \
	-e APP_HOST=localhost \
	-e PORT=4000 \
	--network el_kube_default --publish 4000:4000 el_kube:latest

kubernetes.setup:
	kubectl create -f k8s/pvc.yaml
	kubectl create -f k8s/db.yaml
	kubectl create -f k8s/db-svc.yaml
	kubectl create -f k8s/el-kube-public-svc.yaml