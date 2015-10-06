defmodule Distancex.Mixfile do
  use Mix.Project

  def project do
    [app: :distancex,
      version: "0.0.2",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: [
        maintainers: ["Vysakh Sreenivasan"],
        licenses: ["MIT"],
        links: %{github: "https://github.com/vysakh0/distancex"}
      ],
      description: """
      Elixir-wrapper for Google Directions API. Can return the drive time and driving distance between two places.
      """,
      deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:exvcr, "~> 0.5.1", only: [:test]},
    {:httpoison, "~> 0.7.2"},
     {:poison, "~> 1.4"}
    ]
  end
end
