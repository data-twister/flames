defmodule Flames.Mixfile do
  use Mix.Project

  @version "1.5.8"
  def project do
    [
      app: :flames,
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      name: "flames",
      description: description,
      package: package,
      source_url: "https://github.com/data-twister/flames",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps,
      aliases: aliases
    ]
  end

  def application do
    [
      applications: apps(Mix.env()),
      mod: {Flames, []}
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp apps(_), do: apps

  defp apps do
    [:logger, :phoenix]
  end

  # Need phoenix compiler to compile our views.
  defp compilers(:test) do
    [:phoenix | compilers]
  end

  defp compilers(_) do
    if Code.ensure_loaded?(Phoenix.HTML) do
      [:phoenix | compilers]
    else
      compilers
    end
  end

  defp compilers do
    [:phoenix] ++ Mix.compilers()
  end

  defp deps do
    [
      {:ecto, ">= 0.0.0"},
      {:phoenix, ">= 1.5.8"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_view, "~> 0.15.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: [:docs, :dev]},
      {:earmark, ">= 0.0.0", only: [:docs, :dev]},
      {:floki, ">= 0.0.0", only: :test}
    ]
  end

  defp description do
    """
    Live error monitoring to watch your Phoenix app going up in flames in real time!

    Open source version of error aggregation services. Hooks into Elixir's Logger to provide accurate error
    reporting all throughout your application.
    """
  end

  defp package do
    [
      maintainers: ["Jason Clark"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "http://github.com/data-twister/flames",
        "Docs" => "http://hexdocs.pm/flames/"
      }
    ]
  end

  defp aliases do
    [
      publish: ["build.assets", "hex.publish", "hex.publish docs", "tag"],
      "build.assets": &npm_build/1,
      tag: &tag_release/1
    ]
  end

  defp tag_release(_) do
    Mix.shell().info("Tagging release as #{@version}")
    System.cmd("git", ["tag", "-a", "v#{@version}", "-m", "v#{@version}"])
    System.cmd("git", ["push", "--tags"])
  end

  defp npm_build(_) do
    Mix.shell().info([IO.ANSI.cyan(), "Building assets...", IO.ANSI.default_color()])
    System.cmd("npm", ["run", "build"])
  end
end
