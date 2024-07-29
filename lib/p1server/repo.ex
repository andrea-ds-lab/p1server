defmodule P1server.Repo do
  use Ecto.Repo,
    otp_app: :p1server,
    adapter: Ecto.Adapters.Postgres
end
