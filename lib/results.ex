defmodule Distancex.Result do
  defstruct [:distance, :duration]
end

defmodule Distancex.Results do
  @no_results %{
    "rows" => [ %{"elements" => [ %{"status"=> "ZERO_RESULTS"}] } ]
  }

  def parse(@no_results, _t)  do
    {:error, "No results found"}
  end

  def parse(rows, "both") do
    {parse(rows, "distance"), parse(rows, "duration")}
  end

  def parse(%{"rows" => [%{"elements" => ele }] }, type) do
    [%{ ^type => %{ "value" => t } }] =  ele
    t
  end

  def parse(%{"status" => "REQUEST_DENIED", "error_message" => msg}, _t)  do
    {:error, msg}
  end
end
