# Distancex

Elixir-wrapper for Google Directions API. Can return the drive time and driving distance between two places.

A sample [http request and the corresponding json response](https://maps.googleapis.com/maps/api/distancematrix/json?origins=2+BC&destinations=San+Francisco)

## Installation

**Dependencies**: Make sure you have Erlang 18+ version installed and Elixir 1.x version.
This hex package will not work with Erlang 17.x version.

Add distancex to your list of dependencies in `mix.exs`:

```elixir
def deps do
 [{:distancex, "~> 0.0.3"} ]
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
iex> Distancex.distance_time("Vancouver", "San Francisco")
#=> {1529113, 53750}
```

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
