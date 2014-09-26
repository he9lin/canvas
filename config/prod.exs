use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert
config :repo, database_url: System.get_env("DATABASE_URL")

config :phoenix, Canvas.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_canvas_key",
  session_secret: "+O0B7ZIFEUM(SDM7P1E9XZQ9PK*!0%1G0=U1Q$I=DQ+QJK=L&NJJT&0KO1FS*&)JLR*KVVG"

config :logger, :console,
  level: :info,
  metadata: [:request_id]
