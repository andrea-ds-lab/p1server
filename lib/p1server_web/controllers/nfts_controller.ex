defmodule P1serverWeb.NftsController do
  use P1serverWeb, :controller

  def index(conn, _params) do
    # Here you would typically fetch some data, for example from a database
    api_key = System.get_env("API_KEY")
    IO.inspect(api_key)

    data = %{
      message: "Hello, world!",
      key: api_key
    }

    base_path = "https://eth-mainnet.g.alchemy.com/v2/#{api_key}/getNFTsForOwner?owner=0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045&withMetadata=false&pageSize=100"
    IO.inspect(base_path)
    data = Map.put(data, "path_api", base_path)

    data = Map.put(data, "res", fetch_nfts(base_path))

    # Respond with JSON
    json(conn, data)
  end

  def fetch_nfts(url) do


    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts("Success:")
        IO.inspect(body)
      _ -> :failed
    end

  end

end
