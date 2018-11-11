defmodule Exred.Node.GrpcTwin.MixProject do
  use Mix.Project

  def project do
    [
      app: :exred_node_grpc_twin,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
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
end
