defmodule PaymentsExample.Repo do
  use Ecto.Repo,
    otp_app: :payments_example,
    adapter: Ecto.Adapters.Postgres
end
