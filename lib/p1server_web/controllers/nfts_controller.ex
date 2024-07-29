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

    base_path = "https://polygon-mainnet.g.alchemy.com/v2/#{api_key}/getNFTsForOwner?owner=0xd0AEd413c92622E229C859AAd1f05d15552D820e&withMetadata=false&pageSize=100"
    data = Map.put(data, "path_api", base_path)


    data = Map.put(data, "response", fetch_nfts(base_path))

    # Respond with JSON
    json(conn, data)
  end

  def fetch_nfts(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, json} ->
            IO.puts("Success:")
            IO.inspect(json)

          {:error, error} ->
            IO.puts("Failed to decode JSON: #{error}")
        end

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        IO.puts("Received unexpected status code: #{status_code}")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Failed to fetch data: #{reason}")
    end
  end

end
