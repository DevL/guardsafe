defmodule Guardsafe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :guardsafe,
      version: "0.1.0",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    Macros expanding into code that can be safely used in guard clauses.
    """
  end

  defp package do
    [
      contributors: ["Lennart Fridén"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/DevL/guardsafe"}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:inch_ex, only: :docs}]
  end
end
