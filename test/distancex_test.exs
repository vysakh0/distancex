defmodule DistancexTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  setup_all do
    ExVCR.Config.filter_url_params(true)
    :ok
  end

  test "distance & time response if success" do
    use_cassette "success" do
      assert Distancex.distance("Vancouver", "San Francisco") == 1036074
      assert Distancex.duration("Vancouver", "San Francisco") == 35612
      assert Distancex.distance_time("Vancouver", "San Francisco") == {1036074, 35612}
    end
  end

  test "distance & time: error when no results" do
    use_cassette "no_results" do
      assert Distancex.distance("yolo", "z") == {:error, "No results found"}
      assert Distancex.duration("yolo", "z") == {:error, "No results found"}
    end
  end

  test "distance & time: error when req denied" do
    Application.put_env(:distancex, :api_key, "Wrong key")
    use_cassette "request_denied" do
      assert Distancex.distance("Vancouver", "San Francisco") == {:error, "The provided API key is invalid."}
      assert Distancex.duration("Vancouver", "San Francisco") == {:error, "The provided API key is invalid."}
    end
  end

end
