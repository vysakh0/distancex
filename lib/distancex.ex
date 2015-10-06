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
      iex> Distancex.distance("Vancouver", "San Francisco")
      #=> 1529113
      iex> Distancex.duration("Vancouver", "San Francisco")
      #=> 53750
      iex> Distancex.distance("49.2827N,123.1207W", "7.7833N,122.4167W")
      #=> 1529113
      iex> Distancex.duration("49.2827N,123.1207W", "7.7833N,122.4167W")
      #=> 53750
      iex> Distancex.distance_time("49.2827N,123.1207W", "7.7833N,122.4167W")
      #=> {1529113, 53750}
  """
  @doc """
  Given an origin and destination, returns the distance betwen them in  metres
      iex> Distancex.distance("Vancouver", "San Francisco")
      #=> 1529113
      iex> Distancex.distance("49.2827N,123.1207W", "7.7833N,122.4167W")
      #=> 1529113
  """

  def distance(org, des), do: result(org, des, "distance")

  @doc """
  Given an origin and destination, returns the time to travel betwen them in seconds
      iex> Distancex.distance("Vancouver", "San Francisco")
      #=> 53750
      iex> Distancex.duration("49.2827N,123.1207W", "7.7833N,122.4167W")
      #=> 53750
  """
  def duration(org, des), do: result(org, des, "duration")

  @doc """
  To get both distance and time between two places. Returns a tuple of {distance, duration}.

      iex> Distancex.distance_time("Vancouver", "San Francisco")
      #=> {1529113, 53750}
      iex> Distancex.distance_time("49.2827N,123.1207W", "7.7833N,122.4167W")
      #=> {1529113, 53750}
  """
  def distance_time(org, des), do: result(org, des, "both")

  defp result(org, des, type) do
    HTTPoison.start
    %{body: body} = form_url(org, des) |> HTTPoison.get!
    Poison.decode!(body)
    |> Distancex.Results.parse(type)
  end

  defp form_url(origin, destination) do
    %{origins: origin, destinations: destination, key: key}
    |> URI.encode_query
    |> final_url
  end

  defp final_url(url) do
    "https://maps.googleapis.com/maps/api/distancematrix/json?" <> url
  end

  defp key do
    Application.get_env(:distancex, :api_key)
  end
end
