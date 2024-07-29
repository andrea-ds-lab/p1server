defmodule P1serverWeb.WithUrlParamsController do
  use P1serverWeb, :controller

  def index(conn, %{"address" => address}) do


    json(conn, %{address: address})

  end


end
