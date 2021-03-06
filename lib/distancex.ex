defmodule Distancex do

  @moduledoc """
  Wrapper for Google Directions API. Can return the drive time and driving distance between two places.

  A sample [http request and the corresponding json response](https://maps.googleapis.com/maps/api/distancematrix/json?origins=2+BC&destinations=San+Francisco)

  ### Config
  Create a project from your Google developer console and get an API key. Set this API key in your config file.

  # config.exs
  config :distancex, api_key: "YourAPIKEY"

  The origin and destinations can be either a place name or a combo of latitude and longitude

  ### Examples

  $ iex -S mix

      iex> Distancex.result("Vancouver", "San Francisco")
      #=> %Distancex.Result{
            distance: %{text: "1,036 km", value: 1036074},
            duration: %{text: "9 hours 54 mins", value: 35612}
          }
      iex> Distancex.result("49.2827N,123.1207W", "7.7833N,122.4167W").distance
      #=> %{text: "1,036 km", value: 1036074}
      iex> Distancex.result("49.2827N,123.1207W", "7.7833N,122.4167W").duration
      #=>  %{text: "9 hours 54 mins", value: 35612}

  You can pass optional paramater as an Elixir map.
  Please see the list of available optional parameters in this url
  https://developers.google.com/maps/documentation/distance-matrix/intro

      iex> Distancex.result("Vancouver", "San Francisco", %{units: "imperial"})
      #=> %Distancex.Result{
            distance: %{text: "644 mi", value: 1036074},
            duration: %{text: "9 hours 54 mins", value: 35612}
          }
      iex> Distancex.result("49.2827N,123.1207W", "7.7833N,122.4167W").distance
      #=> %{text: "644 mi", value: 1036074}

  Note the value for distance is in metres and for duration, it is in seconds
  """
  def result(org, des, opts \\ %{}) do
    form_url(org, des, opts)
    |> fetch_results
    |> Poison.decode!
    |> Distancex.Results.parse
  end

  defp form_url(origin, destination, opts) do
    %{origins: origin, destinations: destination, key: key}
    |> Map.merge(opts)
    |> URI.encode_query
    |> final_url
  end

  defp final_url(url) do
    "https://maps.googleapis.com/maps/api/distancematrix/json?" <> url
  end

  defp key do
    Application.get_env(:distancex, :api_key)
  end

  defp fetch_results(url) do
    char_list_url = to_char_list(url)
    { :ok, {{_version, 200, _reason_phrase}, _headers, body } } = :httpc.request(char_list_url)
    body
  end
end
