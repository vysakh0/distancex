# Distancex

Elixir-wrapper for Google Directions API. Can return the drive time and driving distance between two places.

[![Build Status](https://semaphoreci.com/api/v1/projects/4d42d620-07ac-4d24-8598-f136fb4fc62d/606943/badge.svg)](https://semaphoreci.com/vysakh0/distancex)

A sample [http request and the corresponding json response](https://maps.googleapis.com/maps/api/distancematrix/json?origins=2+BC&destinations=San+Francisco)

## Installation

**Dependencies**: Make sure you have Erlang 18+ version installed and Elixir 1.x version.
This hex package will not work with Erlang 17.x version.

Add distancex to your list of dependencies in `mix.exs`:

```elixir
def deps do
[{:distancex, "~> 0.1.0"} ]
end
```
Install the package

```bash
mix deps.get
```


### Config

```elixir
#config.exs

config :distancex, api_key: "YourAPIKEY"
```


## Usage

The origin and destinations can be either a place name or a combo of latitude and longitude.

```elixir
$ iex -S mix
iex> Distancex.result("Vancouver", "San Francisco")

#=> %Distancex.Result{
#=>  distance: %{text: "1,036 km", value: 1036074},
#=>  duration: %{text: "9 hours 54 mins", value: 35612}
#=> }

iex> Distancex.result("49.2827N,123.1207W", "7.7833N,122.4167W").distance
#=> %{text: "1,036 km", value: 1036074}

iex> Distancex.result("49.2827N,123.1207W", "7.7833N,122.4167W").duration
#=> %{text: "9 hours 54 mins", value: 35612}
```

You can pass optional paramater as an Elixir map.
Please see the list of available optional parameters in this [url]
(https://developers.google.com/maps/documentation/distance-matrix/intro)

```elixir
iex> Distancex.result("Vancouver", "San Francisco", %{units: "imperial"})

#=> %Distancex.Result{
#=>   distance: %{text: "644 mi", value: 1036074},
#=>   duration: %{text: "9 hours 54 mins", value: 35612}
#=> }

iex> Distancex.result("49.2827N,123.1207W", "7.7833N,122.4167W").distance
#=> %{text: "644 mi", value: 1036074}
```

Note: the value for distance is in metres and for duration, it is in seconds

### Invalid key

```elixir
$ iex -S mix
iex> Distancex.distance("Vancouver", "San Francisco")
#=> {:error, "The provided API key is expired."}
```

- Create a project in [google developer console](https://console.developers.google.com/)
- Enable distance matrix api for that project.
- Get API key


*"Everything we hear is an opinion, not a fact. Everything we see is a perspective, not the truth."
― Marcus Aurelius, Meditations*
