defmodule Exred.Node.GrpcTwin.MixProject do
  use Mix.Project

  @description "Exred node that pairs with an external service"

  def project do
    [
      app: :exred_node_grpc_twin,
      version: "0.1.2",
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
      {:exred_library, "~> 0.1"}
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
