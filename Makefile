app.start.node_a:
	iex --name a@127.0.0.1 -S mix phx.server

app.start.node_b:
	HTTP_PORT=4001 iex --name b@127.0.0.1 -S mix phx.server