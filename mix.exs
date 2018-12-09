defmodule Exred.Node.GrpcTwin.MixProject do
  use Mix.Project

  @description "Exred node that pairs with an external service"

  def project do
    [
      app: :exred_node_grpc_twin,
      version: "0.1.5",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: @description,
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false},
      # {:exred_nodeprototype, "~> 0.1"},
      {:exredrpc, "~> 0.1"},
      # {:exred_node_grpc_server, "~> 0.1.2-alpha2"}
      {:exred_nodeprototype, path: "../exred_nodeprototype"},
      {:exred_node_grpc_server, path: "../exred_node_grpc_server"}
    ]
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Zsolt Keszthelyi"],
      links: %{
        "GitHub" => "https://github.com/exredorg/exred_node_grpc_twin",
        "Exred" => "http://exred.org"
      },
      files: ["lib", "mix.exs", "README.md", "LICENSE"]
    }
  end
end
