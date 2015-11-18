defmodule DistancexTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  test "distance & time response if success" do
    use_cassette "success" do
      expected_result = %Distancex.Result{
        distance: %{text: "1,036 km", value: 1036074},
        duration: %{text: "9 hours 54 mins", value: 35612}
      }
      result  = Distancex.result("Vancouver", "San Francisco")
      assert  result.distance == expected_result.distance
      assert  result.duration == expected_result.duration
    end
  end

  test "distance & time response with options" do
    use_cassette "success_with_options" do
      expected_result = %Distancex.Result{
        distance: %{text: "644 mi", value: 1036074},
        duration: %{text: "9 hours 54 mins", value: 35612}
      }
      result  = Distancex.result("Vancouver", "San Francisco", %{units: "imperial"})
      assert  result.distance == expected_result.distance
      assert  result.duration == expected_result.duration
    end
  end
  test "distance & time: error when no results" do
    use_cassette "no_results" do
      assert Distancex.result("yolo", "z") == {:error, "No results found"}
    end
  end

  test "distance & time: error when req denied" do
    Application.put_env(:distancex, :api_key, "Wrong key")
    use_cassette "request_denied" do
      assert Distancex.result("Vancouver", "San Francisco") == {:error, "The provided API key is invalid."}
    end
  end

end
