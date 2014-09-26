use Mix.Config

config :repo, database_url: "ecto://postgres:postgres@localhost/canvas_test"

config :phoenix, Canvas.Router,
  port: System.get_env("PORT") || 4001,
  ssl: false,
  cookies: true,
  session_key: "_canvas_key",
  session_secret: "+O0B7ZIFEUM(SDM7P1E9XZQ9PK*!0%1G0=U1Q$I=DQ+QJK=L&NJJT&0KO1FS*&)JLR*KVVG"

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug
