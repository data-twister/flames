defmodule Flames.Logger do
  @behaviour :gen_event

  config_message = """
  Please configure the repo Flames should use in your config.exs file.

      config :flames,
        repo: MyApp.Repo,
        endpoint: MyApp.Endpoint \# (Optional, if using Phoenix)
  """

  Application.get_env(:flames, :repo) || raise(config_message)

  def init(_) do
    {:ok, configure()}
  end

  def init({__MODULE__, name}) do
    {:ok, configure(name, [])}
  end

  def handle_call({:configure, options}, state) do
    {:ok, :ok, configure(options)}
  end

  def handle_call({:configure, opts}, %{name: name}=state) do
    {:ok, :ok, configure(name, opts, state)}
  end

  def handle_event(:flush, state) do
    {:ok, state}
  end

  def handle_info(_msg, state) do
    {:ok, state}
  end

  def terminate(_reason, _state) do
    :ok
  end

  def code_change(_old, state, _extra) do
    {:ok, state}
  end

  defp configure(options \\ []) do
    options = Keyword.merge(options, [])
    flames_config = Keyword.merge(Application.get_env(:logger, :flames, []), options)
    Application.put_env(:logger, :flames, flames_config)
  end



  def handle_event({_level, gl, _event}, state) when node(gl) != node() do
    {:ok, state}
  end

  def handle_event({level, _gl, event}, state) do
    if proceed?(event) && meet_level?(level) do
      Flames.Error.Worker.post_event(level, event)
    end

    {:ok, state}
  end

  defp proceed?({Logger, _msg, _event_time, meta}) do
    Keyword.get(meta, :flames, true)
  end

  defp meet_level?(lvl) do
    Logger.compare_levels(lvl, :warn) in [:gt, :eq]
  end
end
