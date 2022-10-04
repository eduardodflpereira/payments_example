defmodule PaymentsExampleWeb.PageController do
  use PaymentsExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
