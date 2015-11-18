defmodule Distancex.Result do
  defstruct [:distance, :duration]
end

defmodule Distancex.Results do
  @no_results %{
    "rows" => [ %{"elements" => [ %{"status"=> "ZERO_RESULTS"}] } ]
  }

  def parse(@no_results)  do
    {:error, "No results found"}
  end

  def parse(%{"rows" => [%{"elements" => ele }] }) do
    [
      %{
        "distance" => %{
          "value" => dist_value,
          "text" =>  dist_text
        },
        "duration" => %{
          "value" => dur_value,
          "text" =>  dur_text
        }
      }
    ] = ele
    %Distancex.Result{
      distance: %{text: dist_text, value: dist_value},
      duration: %{text: dur_text, value: dur_value},
    }
  end

  def parse(%{"status" => "REQUEST_DENIED", "error_message" => msg})  do
    {:error, msg}
  end
end
