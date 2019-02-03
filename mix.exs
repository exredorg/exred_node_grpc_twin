defmodule Exred.Node.GrpcTwin.MixProject do
  use Mix.Project

  @description "Exred node that pairs with an external service"
  @version File.read!("VERSION") |> String.trim()

  def project do
    [
      app: :exred_node_grpc_twin,
      version: @version,
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
      {:exred_nodeprototype, "~> 0.2"},
      {:exredrpc, "~> 0.1"},
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false},
      {:exred_nodetest, "~> 0.1.0", only: :test},
      # {:exred_node_grpc_server, "~> 0.1", only: test}
      {:exred_node_grpc_server, path: "../exred_node_grpc_server", only: :test}
    ]
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Zsolt Keszthelyi"],
      links: %{
        "GitHub" => "https://github.com/exredorg/exred_node_grpc_twin.git",
        "Exred" => "http://exred.org"
      },
      files: ["lib", "mix.exs", "README.md", "LICENSE"]
    }
  end
end
