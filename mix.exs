defmodule Guardsafe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :guardsafe,
      version: "0.5.0",
      name: "Guardsafe",
      source_url: "https://github.com/DevL/guardsafe",
      homepage_url: "https://hex.pm/packages/guardsafe",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  def application do
    [applications: []]
  end

  defp description do
    """
    Macros expanding into code that can be safely used in guard clauses.
    """
  end

  defp package do
    [
      maintainers: ["Lennart Fridén"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/DevL/guardsafe"}
    ]
  end

  defp deps do
    [
      {:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:inch_ex, ">= 0.4.0", only: :docs}
    ]
  end
end
