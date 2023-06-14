# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start_link(fn -> {1, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, registrations} -> registrations end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {id, registrations} ->
      plot = %Plot{plot_id: id, registered_to: register_to}

      {plot, {id + 1, [plot | registrations]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {id, registrations} ->
      {id, Enum.reject(registrations, &(&1.plot_id == plot_id))}
    end)

    :ok
  end

  def get_registration(pid, plot_id) do
    case Agent.get(pid, fn {id, registrations} ->
           Enum.find(registrations, &(&1.plot_id == plot_id))
         end) do
      nil -> {:not_found, "plot is unregistered"}
      plot -> plot
    end
  end
end
