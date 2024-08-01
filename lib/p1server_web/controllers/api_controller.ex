defmodule P1serverWeb.ApiController do
  use P1serverWeb, :controller

  def index(conn, _params) do
    data = %{
      message: "Hello, world!",
    }
    data = Map.put(data, "response", custom_fetch("https://restcountries.com/v3.1/all"))
    # Respond with JSON
    json(conn, data)
  end

  def fetch_artworks(conn, _params) do
    data = %{}
    data = Map.put(data, "response", custom_fetch("https://api.artic.edu/api/v1/artworks"))
    json(conn, data)
  end

  def custom_fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, json} ->
            IO.puts("Success:")
            # IO.inspect(json) non stampare il risultato dell'API

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
