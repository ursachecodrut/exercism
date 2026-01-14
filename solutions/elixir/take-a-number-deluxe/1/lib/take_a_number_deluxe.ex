defmodule TakeANumberDeluxe do
  use GenServer

  alias TakeANumberDeluxe.State, as: State

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    state =
      case length(init_arg) >= 2 do
        true ->
          min_number = Keyword.get(init_arg, :min_number)
          max_number = Keyword.get(init_arg, :max_number)
          auto_shutdown_timeout = Keyword.get(init_arg, :auto_shutdown_timeout) || :infinity
          State.new(min_number, max_number, auto_shutdown_timeout)

        false ->
          raise ArgumentError, message: "Invalid arguments"
      end

    case state do
      {:ok, state} ->
        GenServer.start_link(__MODULE__, state)

      {:error, error} ->
        {:error, error}
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    case GenServer.call(machine, :queue_new_number) do
      {:ok, number} -> {:ok, number}
      {:error, error} -> {:error, error}
    end
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks

  @impl GenServer
  def init(state) do
    {:ok, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, number, new_state} ->
        {:reply, {:ok, number}, new_state, new_state.auto_shutdown_timeout}

      {:error, _error} ->
        {:reply, {:error, :all_possible_numbers_are_in_use}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, state.auto_shutdown_timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {:ok, new_state} =
      State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)

    {:noreply, new_state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end

