defmodule Exred.Node.GrpcTwinTest do
  use ExUnit.Case
  doctest Exred.Node.GrpcTwin

  test "greets the world" do
    assert Exred.Node.GrpcTwin.hello() == :world
  end
end
