use Mix.Config

config :phoenix, Canvas.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_canvas_key",
  session_secret: "+O0B7ZIFEUM(SDM7P1E9XZQ9PK*!0%1G0=U1Q$I=DQ+QJK=L&NJJT&0KO1FS*&)JLR*KVVG",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


