defmodule Taxis.Repo do
  use Ecto.Repo,
    otp_app: :taxis,
    adapter: Ecto.Adapters.MyXQL
end
