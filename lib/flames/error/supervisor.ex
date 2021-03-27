defmodule Error.Supervisor do
  use DynamicSupervisor

   alias  Error.Queue, as: SERVER
  
@name :error_supervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: @name)
  end

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, [], name: @name)
  end

  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start(hash \\ nil) do
    hash =
      case hash do
        nil -> Base.encode16(:crypto.strong_rand_bytes(8))
        _ -> hash
      end


    child_spec = Error.Queue

    DynamicSupervisor.start_child(@name, child_spec)


    {:ok, "success"}
  end

  def stop(id) do
    SERVER.shutdown(id)

    {:ok, "success"}
  end

end