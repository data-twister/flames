defmodule Error.Queue do
  use GenServer
require Logger
   use DynamicSupervisor

     alias  Error.Queue, as: SERVER
  
  defstruct errors: nil

  @name :error_queue
  @restart_time  Application.get_env(:flames, :ttl, 60) * 1000

    def child_spec(init) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [init]},
      restart: :transient,
      type: :worker
    }
  end

  def init do
 initial_state = %__MODULE__{
      errors: nil
    }
  {:ok,  initial_state}
  end

   def start_link(user) do
    GenServer.start_link(__MODULE__, [], name: @name)
  end

  @impl true
  def init([]) do
    initial_state = %__MODULE__{
      errors: nil
    }

    Logger.info("Started: Error Queue")
    Process.send_after(self(),Task.shutdown(@name, :brutal_kill), @restart_time)

    {:ok, initial_state}
  end

  def broadcast do
     GenServer.call(@name, :broadcast)
  end

  def add(data) do
     GenServer.call(@name, {:add, data})
  end

  ## server funs

  def handle_info(:start_server, state) do
    {:noreply, state}
  end

    def handle_call(
        :broadcast,
        _from,
        state
      ) do
      endpoint = Application.get_env(:flames, :endpoint)
    endpoint && endpoint.broadcast("errors", "errors", state.errors)
    {:reply, {:ok, "sent"}, state.errors}
  end

    def handle_call(
{:add, error},
        _from,
        state
      ) do
      errors = state.errors ++ [error]
      state = %{state | errors: errors}
      Process.send_after(self(), :broadcast, 1000)
    {:noreply, state}
  end

  def handle_call(
{:remove, error},
        _from,
        state
      ) do
      errors = state.errors ++ [error]
      state = %{state | errors: errors}
        Process.send_after(self(), :broadcast, 1000)
    {:noreply, state}
  end

  def handle_call(
        :shutdown,
        _from,
        state
      ) do
    {:stop, {:ok, "Normal Shutdown"}, state.errors}
  end

  def handle_cast(
        :shutdown,
        state
      ) do
    {:stop, :normal, state}
  end

  def shutdown(hash) do
    try do
      GenServer.cast(@name, :shutdown)
      {:ok, "shutdown"}
    catch
      :exit, _ -> {:error, "doesnt_exist"}
    end
  end

end