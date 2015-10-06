defmodule DistancexTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.filter_url_params(true)
    :ok
  end

  test "distance & time response if success" do
    ExVCR.Config.filter_url_params(true)
    use_cassette "success", custom: true do
      assert Distancex.distance("Vancouver", "San Francisco") == 1529113
      assert Distancex.duration("Vancouver", "San Francisco") == 53750
      assert Distancex.distance_time("Vancouver", "San Francisco") == {1529113, 53750}
    end
  end

  test "distance & time: error when no results" do
    use_cassette "no_results", custom: true do
      assert Distancex.distance("Vancouver", "San Francisco") == {:error, "No results found"}
      assert Distancex.duration("Vancouver", "San Francisco") == {:error, "No results found"}
    end
  end
  test "distance & time: error when req denied" do
    use_cassette "request_denied", custom: true do
      assert Distancex.distance("Vancouver", "San Francisco") == {:error, "The provided API key is expired."}
      assert Distancex.duration("Vancouver", "San Francisco") == {:error, "The provided API key is expired."}
    end
  end

end
